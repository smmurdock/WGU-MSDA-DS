-- Index on region_name in the region table
CREATE INDEX idx_region_name ON region(region_name);

-- Index on country_name and region_id in the country table
CREATE INDEX idx_country_name ON country(country_name);
CREATE INDEX idx_country_region_id ON country(region_id);

-- Index on item_type_name in the item_type table
CREATE INDEX idx_item_type_name ON item_type(item_type_name);

-- Index on sales_channel_name in the sales_channel table
CREATE INDEX idx_sales_channel_name ON sales_channel(sales_channel_name);

-- Composite index on order_date and country_id in the orders table
CREATE INDEX idx_orders_order_date_country_id ON orders(order_date, country_id);

-- Index on order_id in the sales_detail table
CREATE INDEX idx_sales_detail_order_id ON sales_detail(order_id);

-- Composite index on total_revenue and total_profit in the sales_detail table
CREATE INDEX idx_sales_detail_revenue_profit ON sales_detail(total_revenue, total_profit);