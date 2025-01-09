-- Insert data into `region` table
INSERT INTO region (region_name)
    SELECT DISTINCT region
    FROM bad_sales_records
    WHERE region IS NOT NULL;

-- Insert data into `country` table
INSERT INTO country (country_name, region_id)
    SELECT DISTINCT bsr.country, r.region_id
    FROM bad_sales_records AS bsr
    JOIN region AS r ON bsr.region = r.region_name
    WHERE bsr.country IS NOT NULL;

-- Insert data into `item_type` table
INSERT INTO item_type (item_type_name)
    SELECT DISTINCT item_type
    FROM bad_sales_records
    WHERE item_type IS NOT NULL;

-- Insert data into `sales_channel` table
INSERT INTO sales_channel (sales_channel_name)
    SELECT DISTINCT sales_channel
    FROM bad_sales_records
    WHERE sales_channel IS NOT NULL;

-- Insert data into `order` table
INSERT INTO order (order_priority, order_date, ship_date, country_id, item_type_id, sales_channel_id)
    SELECT
        bsr.order_priority,
        bsr.order_date,
        bsr.ship_date,
        c.country_id,
        it.item_type_id,
        sc.sales_channel_id
    FROM bad_sales_records AS bsr
    JOIN country AS c ON bsr.country = c.country_name
    JOIN item_type AS it ON bsr.item_type = it.item_type_name
    JOIN sales_channel AS sc ON bsr.sales_channel = sc.sales_channel_name;

-- Insert data into `sales_detail` table
INSERT INTO sales_detail (order_id, units_sold, unit_price, unit_cost, total_revenue, total_cost, total_profit)
    SELECT
        o.order_id,
        bsr.unit_sold,
        bsr.unit_price,
        bsr.unit_cost,
        bsr.total_revenue,
        bsr.total_cost,
        bsr.total_profit
    FROM bad_sales_records AS bsr
    JOIN order AS o ON bsr.order_id = o.order_id;

-- Verify data in `regions` table
SELECT *
FROM region;

-- Verify data in `country` table
SELECT *
FROM country
LIMIT 10;

-- Verify data in `item_type` table
SELECT *
FROM item_type
LIMIT 10;

-- Verify data in `sales_channel` table
SELECT *
FROM sales_channel
LIMIT 10;

-- Verify data in `order` table
SELECT *
FROM order
LIMIT 10;

-- Verify data in `sales_detail` table
SELECT *
FROM sales_detail
LIMIT 10;

-- Drop the temporary table
DROP TABLE bad_sales_records;