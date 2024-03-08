import streamlit as st
import pandas as pd
import psycopg2

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
st.dataframe(df)

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
    "Example 1": "SELECT * FROM factory.{selected_table} LIMIT 5;",
    "Example 2": "SELECT column1, column2 FROM factory.{selected_table} WHERE condition;",
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