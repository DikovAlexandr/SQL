--
-- PostgreSQL database dump
--

-- Dumped from database version 16.1
-- Dumped by pg_dump version 16.1

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: factory; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA factory;


ALTER SCHEMA factory OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: employees; Type: TABLE; Schema: factory; Owner: postgres
--

CREATE TABLE factory.employees (
    employee_id integer NOT NULL,
    full_name character varying(255) NOT NULL,
    "position" character varying(255) NOT NULL,
    salary numeric NOT NULL,
    contact_info character varying(255)
);


ALTER TABLE factory.employees OWNER TO postgres;

--
-- Name: employees_employee_id_seq; Type: SEQUENCE; Schema: factory; Owner: postgres
--

CREATE SEQUENCE factory.employees_employee_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE factory.employees_employee_id_seq OWNER TO postgres;

--
-- Name: employees_employee_id_seq; Type: SEQUENCE OWNED BY; Schema: factory; Owner: postgres
--

ALTER SEQUENCE factory.employees_employee_id_seq OWNED BY factory.employees.employee_id;


--
-- Name: items; Type: TABLE; Schema: factory; Owner: postgres
--

CREATE TABLE factory.items (
    item_id integer NOT NULL,
    item_name character varying(255) NOT NULL,
    item_description text,
    price numeric NOT NULL
);


ALTER TABLE factory.items OWNER TO postgres;

--
-- Name: items_item_id_seq; Type: SEQUENCE; Schema: factory; Owner: postgres
--

CREATE SEQUENCE factory.items_item_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE factory.items_item_id_seq OWNER TO postgres;

--
-- Name: items_item_id_seq; Type: SEQUENCE OWNED BY; Schema: factory; Owner: postgres
--

ALTER SEQUENCE factory.items_item_id_seq OWNED BY factory.items.item_id;


--
-- Name: partners; Type: TABLE; Schema: factory; Owner: postgres
--

CREATE TABLE factory.partners (
    partner_id integer NOT NULL,
    partner_name character varying(255) NOT NULL,
    partner_type character varying(50) NOT NULL,
    contact_info character varying(255)
);


ALTER TABLE factory.partners OWNER TO postgres;

--
-- Name: partners_partner_id_seq; Type: SEQUENCE; Schema: factory; Owner: postgres
--

CREATE SEQUENCE factory.partners_partner_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE factory.partners_partner_id_seq OWNER TO postgres;

--
-- Name: partners_partner_id_seq; Type: SEQUENCE OWNED BY; Schema: factory; Owner: postgres
--

ALTER SEQUENCE factory.partners_partner_id_seq OWNED BY factory.partners.partner_id;


--
-- Name: transactions; Type: TABLE; Schema: factory; Owner: postgres
--

CREATE TABLE factory.transactions (
    transaction_id integer NOT NULL,
    transaction_date date NOT NULL,
    partner_id integer NOT NULL,
    item_type character varying(50) NOT NULL,
    item_id integer NOT NULL,
    quantity integer NOT NULL,
    transaction_type character varying(50) NOT NULL,
    transaction_amount numeric NOT NULL,
    transaction_details text
);


ALTER TABLE factory.transactions OWNER TO postgres;

--
-- Name: transactions_transaction_id_seq; Type: SEQUENCE; Schema: factory; Owner: postgres
--

CREATE SEQUENCE factory.transactions_transaction_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE factory.transactions_transaction_id_seq OWNER TO postgres;

--
-- Name: transactions_transaction_id_seq; Type: SEQUENCE OWNED BY; Schema: factory; Owner: postgres
--

ALTER SEQUENCE factory.transactions_transaction_id_seq OWNED BY factory.transactions.transaction_id;


--
-- Name: employees employee_id; Type: DEFAULT; Schema: factory; Owner: postgres
--

ALTER TABLE ONLY factory.employees ALTER COLUMN employee_id SET DEFAULT nextval('factory.employees_employee_id_seq'::regclass);


--
-- Name: items item_id; Type: DEFAULT; Schema: factory; Owner: postgres
--

ALTER TABLE ONLY factory.items ALTER COLUMN item_id SET DEFAULT nextval('factory.items_item_id_seq'::regclass);


--
-- Name: partners partner_id; Type: DEFAULT; Schema: factory; Owner: postgres
--

ALTER TABLE ONLY factory.partners ALTER COLUMN partner_id SET DEFAULT nextval('factory.partners_partner_id_seq'::regclass);


--
-- Name: transactions transaction_id; Type: DEFAULT; Schema: factory; Owner: postgres
--

ALTER TABLE ONLY factory.transactions ALTER COLUMN transaction_id SET DEFAULT nextval('factory.transactions_transaction_id_seq'::regclass);


--
-- Data for Name: employees; Type: TABLE DATA; Schema: factory; Owner: postgres
--

-- COPY factory.employees (employee_id, full_name, "position", salary, contact_info) FROM stdin;
-- 6	John Doe	Production Manager	60000.00	john.doe@example.com
-- 7	Jane Smith	Quality Control Specialist	50000.00	jane.smith@example.com
-- 8	Bob Johnson	Packaging Supervisor	55000.00	bob.johnson@example.com
-- 9	Alice Brown	Marketing Coordinator	48000.00	alice.brown@example.com
-- 10	Charlie Davis	Sales Representative	55000.00	charlie.davis@example.com
-- \.

INSERT INTO factory.employees (full_name, position, salary, contact_info)
VALUES
    ('John Doe', 'Production Manager', 60000.00, 'john.doe@example.com'),
    ('Jane Smith', 'Quality Control Specialist', 50000.00, 'jane.smith@example.com'),
    ('Bob Johnson', 'Packaging Supervisor', 55000.00, 'bob.johnson@example.com'),
    ('Alice Brown', 'Marketing Coordinator', 48000.00, 'alice.brown@example.com'),
    ('Charlie Davis', 'Sales Representative', 55000.00, 'charlie.davis@example.com');


--
-- Data for Name: items; Type: TABLE DATA; Schema: factory; Owner: postgres
--

-- COPY factory.items (item_id, item_name, item_description, price) FROM stdin;
-- 11	Handmade Soap	Artisanal soap with natural ingredients	7.00
-- 12	Scented Soap	Soap with refreshing scents for relaxation	8.00
-- 13	Colorful Soap	Vibrantly colored soap bars	6.00
-- 14	Moisturizing Soap	Soap enriched with glycerin for hydration	9.00
-- 15	Special Edition Soap	Limited edition soap with unique features	12.00
-- \.

INSERT INTO factory.items (item_name, item_description, price)
VALUES
    ('Handmade Soap', 'Artisanal soap with natural ingredients', 7.00),
    ('Scented Soap', 'Soap with refreshing scents for relaxation', 8.00),
    ('Colorful Soap', 'Vibrantly colored soap bars', 6.00),
    ('Moisturizing Soap', 'Soap enriched with glycerin for hydration', 9.00),
    ('Special Edition Soap', 'Limited edition soap with unique features', 12.00);


--
-- Data for Name: partners; Type: TABLE DATA; Schema: factory; Owner: postgres
--

-- COPY factory.partners (partner_id, partner_name, partner_type, contact_info) FROM stdin;
-- 11	Supplier1	Supplier	supplier1@example.com
-- 12	Manufacturer1	Manufacturer	manufacturer1@example.com
-- 13	Distributor1	Distributor	distributor1@example.com
-- 14	Retailer1	Retailer	retailer1@example.com
-- 15	ServiceProvider1	Service Provider	serviceprovider1@example.com
-- \.

INSERT INTO factory.partners (partner_name, partner_type, contact_info)
VALUES
    ('Supplier1', 'Supplier', 'supplier1@example.com'),
    ('Manufacturer1', 'Manufacturer', 'manufacturer1@example.com'),
    ('Distributor1', 'Distributor', 'distributor1@example.com'),
    ('Retailer1', 'Retailer', 'retailer1@example.com'),
    ('ServiceProvider1', 'Service Provider', 'serviceprovider1@example.com');


--
-- Data for Name: transactions; Type: TABLE DATA; Schema: factory; Owner: postgres
--

-- COPY factory.transactions (transaction_id, transaction_date, partner_id, item_type, item_id, quantity, transaction_type, transaction_amount, transaction_details) FROM stdin;
-- 16	2024-02-15	11	Product	11	50	Purchase	5000.00	Bulk purchase of raw materials
-- 17	2024-02-18	13	Service	11	2	Order	300.00	Consulting services for production
-- 18	2024-02-20	12	Product	12	20	Purchase	15000.00	Order for manufacturing raw materials
-- 19	2024-02-22	14	Product	13	10	Purchase	1000.00	Purchase of hardware tools
-- 20	2024-02-25	15	Service	12	1	Order	1000.00	Installation and setup of equipment
-- \.

INSERT INTO factory.transactions (transaction_date, partner_id, item_type, item_id, quantity, transaction_type, transaction_amount, transaction_details)
VALUES
    ('2024-02-15', 1, 'Product', 1, 50, 'Purchase', 5000.00, 'Bulk purchase of raw materials'),
    ('2024-02-18', 3, 'Service', 2, 2, 'Order', 300.00, 'Consulting services for production'),
    ('2024-02-20', 2, 'Product', 3, 20, 'Purchase', 15000.00, 'Order for manufacturing raw materials'),
    ('2024-02-22', 4, 'Product', 4, 10, 'Purchase', 1000.00, 'Purchase of hardware tools'),
    ('2024-02-25', 5, 'Service', 5, 1, 'Order', 1000.00, 'Installation and setup of equipment');


--
-- Name: employees_employee_id_seq; Type: SEQUENCE SET; Schema: factory; Owner: postgres
--

SELECT pg_catalog.setval('factory.employees_employee_id_seq', 10, true);


--
-- Name: items_item_id_seq; Type: SEQUENCE SET; Schema: factory; Owner: postgres
--

SELECT pg_catalog.setval('factory.items_item_id_seq', 15, true);


--
-- Name: partners_partner_id_seq; Type: SEQUENCE SET; Schema: factory; Owner: postgres
--

SELECT pg_catalog.setval('factory.partners_partner_id_seq', 15, true);


--
-- Name: transactions_transaction_id_seq; Type: SEQUENCE SET; Schema: factory; Owner: postgres
--

SELECT pg_catalog.setval('factory.transactions_transaction_id_seq', 20, true);


--
-- Name: employees employees_pkey; Type: CONSTRAINT; Schema: factory; Owner: postgres
--

ALTER TABLE ONLY factory.employees
    ADD CONSTRAINT employees_pkey PRIMARY KEY (employee_id);


--
-- Name: items items_pkey; Type: CONSTRAINT; Schema: factory; Owner: postgres
--

ALTER TABLE ONLY factory.items
    ADD CONSTRAINT items_pkey PRIMARY KEY (item_id);


--
-- Name: partners partners_pkey; Type: CONSTRAINT; Schema: factory; Owner: postgres
--

ALTER TABLE ONLY factory.partners
    ADD CONSTRAINT partners_pkey PRIMARY KEY (partner_id);


--
-- Name: transactions transactions_pkey; Type: CONSTRAINT; Schema: factory; Owner: postgres
--

ALTER TABLE ONLY factory.transactions
    ADD CONSTRAINT transactions_pkey PRIMARY KEY (transaction_id);


--
-- Name: transactions transactions_item_id_fkey; Type: FK CONSTRAINT; Schema: factory; Owner: postgres
--

ALTER TABLE ONLY factory.transactions
    ADD CONSTRAINT transactions_item_id_fkey FOREIGN KEY (item_id) REFERENCES factory.items(item_id);


--
-- Name: transactions transactions_partner_id_fkey; Type: FK CONSTRAINT; Schema: factory; Owner: postgres
--

ALTER TABLE ONLY factory.transactions
    ADD CONSTRAINT transactions_partner_id_fkey FOREIGN KEY (partner_id) REFERENCES factory.partners(partner_id);


--
-- PostgreSQL database dump complete
--

