-- Build Database: D597_Task_1
DROP DATABASE IF EXISTS "D597_Task_1";

-- Create Database: "D597_Task_1"
-- (WGU Webinar 2, 2024)
CREATE DATABASE "D597_Task_1"
    WITH
    OWNER = postgres
    ENCODING = "UTF8"
    LC_COLLATE = 'English_United States.1252'
    LC_CTYPE = 'English_United States.1252'
    TABLESPACE = pg_default
    CONNECTION LIMIT = -1
    IS_TEMPLATE = False;

-- Create a temporary table for import
CREATE TABLE bad_sales_records (
    region VARCHAR(255),
    country VARCHAR(255),
    item_type VARCHAR(255),
    sales_channel VARCHAR(255),
    order_priority CHAR(1),
    order_date DATE,
    order_id INT,
    ship_date DATE,
    units_sold INT,
    unit_price DECIMAL(10, 2),
    unit_cost DECIMAL(10, 2),
    total_revenue DECIMAL(10, 2),
    total_cost DECIMAL(10, 2),
    total_profit DECIMAL(10, 2)
);

-- Import the CSV data to the temporary table
COPY bad_sales_records (
    region, country, item_type, sales_channel, order_priority, 
    order_date, ship_date, units_sold, unit_price,
    unit_cost, total_revenue, total_cost, total_profit
)
FROM "C:\Users\student\Downloads\1000000 Sales Records.csv"
DELIMITED ','
CSV HEADER;
