import streamlit as st
import pandas as pd
import psycopg2

def INSERT_DB(cur_df, ed_df, table, connection, cursor):
    try:
        if ed_df.shape[0] > cur_df.shape[0]:
            string_q = f"INSERT INTO factory.{table}"
            string_q += " ("
            string_q += ", ".join(cur_df.columns)
            string_q += ") VALUES "
            string_add = [" " for i in range(cur_df.shape[0], ed_df.shape[0])]
            data = []
            for i in range(cur_df.shape[0], ed_df.shape[0]):
                data += [i if type(i) is str else int(i) for i in ed_df.values[i]]
                string_add[i-cur_df.shape[0]] = "("
                string_add[i-cur_df.shape[0]] += ", ".join(["%s" for i in ed_df.values[i]])
            string_q += "), ".join(string_add)
            string_q += ")"
            print(string_q)
            print(data)
            cursor.execute(string_q, data)
            connection.commit()
    except Exception as e:
            st.error(f"Error executing: '{string_q}': {e}")

def UPDATE_DB(cur_df, ed_df, table, connection, cursor):
    try:
        if not edited_df.equals(df):
            string_q = f"UPDATE factory.{table} SET "
            string_q += " = %s, ".join(cur_df.columns[1:])
            string_q += " = %s "
            string_q += f" WHERE {cur_df.columns[0]} = %s;"
            for i in range(cur_df.shape[0]):
                if ed_df.values[i].tolist() != cur_df.values[i].tolist():
                    data = [i if type(i) is str else int(i) for i in ed_df.values[i][1:]]
                    print(ed_df.values[i][0])
                    data.append(int(ed_df.values[i][0]))
                    print(string_q)
                    print(data)
                    cursor.execute(string_q, data)                
            connection.commit()
    except Exception as e:
        st.error(f"Error executing: '{string_q}': {e}")

def DELETE_DB(cur_df, ed_df, table, connection, cursor):
    try:
        if ed_df.shape[0] < cur_df.shape[0]:
            for i in range(cur_df.shape[0]):
                if not (cur_df[cur_df.columns[0]][i] in ed_df[cur_df.columns[0]].tolist()):
                    print(cur_df[cur_df.columns[0]][i])
                    print(ed_df[cur_df.columns[0]][:])
                    print(int(cur_df[cur_df.columns[0]][i]))
                    cursor.execute(f"DELETE FROM factory.{table} WHERE {cur_df.columns[0]} = %s;", (int(cur_df[cur_df.columns[0]][i]),))
                    connection.commit()
    except Exception as e:
        st.error(f"Error executing: '{'DELETE'}': {e}")

connection = psycopg2.connect(
    dbname="soap_factory",
    user="postgres",
    password="1234",
    host="127.0.0.1",
    port="5432"
)
cursor = connection.cursor()

# Get list of tables in factory
cursor.execute("SELECT table_name FROM information_schema.tables WHERE table_schema='factory' ORDER BY table_name;")
tables = cursor.fetchall()
tables = [table[0] for table in tables]

# List of tables to select
selected_table = st.selectbox("Choose a table", tables)

# Table view
cursor.execute(f"SELECT * FROM factory.{selected_table};")
data = cursor.fetchall()
columns = [desc[0] for desc in cursor.description]
df = pd.DataFrame(data, columns=columns)
# st.dataframe(df)

edited_df = st.data_editor(df, num_rows="dynamic")

print(edited_df.shape[0] - df.shape[0])
if edited_df.shape[0] > df.shape[0]:
    if st.button("INSERT"):
        INSERT_DB(df, edited_df, selected_table, connection, cursor)
elif not edited_df.equals(df) and edited_df.shape[0] == df.shape[0]:
    if st.button("UPDATE"):
     UPDATE_DB(df, edited_df, selected_table, connection, cursor)
elif edited_df.shape[0] < df.shape[0]:
    if st.button("DELETE"):
        DELETE_DB(df, edited_df, selected_table, connection, cursor)

# Enter the SQL query
query = st.text_area("Enter SQL-query", f"SELECT * FROM factory.{selected_table};")

# Button to execute entered SQL query
if st.button("Execute SQL-query"):
    try:
        cursor.execute(query)
        result_data = cursor.fetchall()
        result_columns = [desc[0] for desc in cursor.description]
        result_df = pd.DataFrame(result_data, columns=result_columns)
        st.dataframe(result_df)
    except Exception as e:
        st.error(f"Error executing SQL-query: {e}")

# Predefined queries
predefined_queries = {
    "Example 1": f"SELECT * FROM factory.{selected_table} LIMIT 3;",
    "Example 2": f"SELECT column1, column2 FROM factory.{selected_table} WHERE condition;",
    # TODO: Add more predefined queries
}

# Buttons to execute predefined queries
for query_name, query_text in predefined_queries.items():
    if st.button(query_name):
        try:
            cursor.execute(query_text)
            result_data = cursor.fetchall()
            result_columns = [desc[0] for desc in cursor.description]
            result_df = pd.DataFrame(result_data, columns=result_columns)
            st.dataframe(result_df)
        except Exception as e:
            st.error(f"Error executing: '{query_name}': {e}")

# Close the connection
cursor.close()
connection.close()