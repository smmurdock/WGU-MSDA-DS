-- Aggregate the total sales per region
SELECT
    r.region_name,
    SUM(sd.total_revenue) AS total_sales
FROM sales_detail AS sd
JOIN order AS o ON sd.order_id = o.order_id
JOIN country AS c ON o.country_id = c.country_id
JOIN region AS r ON c.region_id = r.region_id
GROUP BY r.region_name
ORDER BY total_sales DESC;

-- Aggregate the total sales per country
SELECT
    c.country_name,
    SUM(sd.total_revenue) AS total_sales
FROM sales_detail AS sd
JOIN order AS o ON sd.order_id = o.order_id
JOIN country AS c ON o.country_id = c.country_id
GROUP BY c.country_name
ORDER BY total_sales DESC;

-- Identify the top 5 countries by total units sold
SELECT 
    c.country_name, 
    SUM(sd.units_sold) AS total_units_sold
FROM sales_detail AS sd
JOIN order AS o ON sd.order_id = o.order_id
JOIN country AS c ON o.country_id = c.country_id
GROUP BY c.country_name
ORDER BY total_units_sold DESC
LIMIT 5;

-- Identify profit margin by item type
SELECT
    it.item_type_name,
    SUM(sd.total_profit) / SUM(sd.total_revenue) * 100 AS profit_margin
FROM item_type AS it
JOIN order AS o ON it.item_type_id = o.item_type_id
JOIN sales_detail AS sd ON o.order_id = sd.order_id
GROUP BY it.item_type_name
ORDER BY profit_margin DESC;

-- Identify month-over-month-sales by country and calculate the percent change from the previous month
WITH monthly_sales AS (
    SELECT
        c.country_name,
        DATE_TRUNC('month', o.order_date) AS month,
        SUM(sd.total_revenue) AS total_sales
    FROM sales_detail AS sd
    JOIN order AS o ON sd.order_id = o.order_id
    JOIN country AS c ON o.country_id = c.country_id
    GROUP BY
        c.country_name, 
        DATE_TRUNC('month', o.order_date)
),
sales_with_lag AS (
    SELECT
        country_name,
        month,
        total_sales,
        LAG(total_sales) OVER (PARTITION BY country_name ORDER BY month) AS previous_month_sales
    FROM monthly_sales
)
SELECT
    country_name,
    month,
    total_sales,
    previous_month_sales,
    CASE
        WHEN previous_month_sales IS NULL THEN NULL
        ELSE (total_sales - previous_month_sales) / previous_month_sales * 100
    END AS month_over_month_change
FROM sales_with_lag
ORDER BY
    country_name, 
    month;
