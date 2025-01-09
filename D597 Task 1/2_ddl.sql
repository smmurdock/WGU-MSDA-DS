-- Create `region` table
CREATE TABLE region (
    region_id SERIAL PRIMARY KEY,
    region_name VARCHAR(255) NOT NULL,
    -- Add constraint
    CONSTRAINT "region_name_not_empty" CHECK (LENGTH(TRIM(region_name)) >= 0)
);

-- Create `country` table
CREATE TABLE country (
    country_id SERIAL PRIMARY KEY,
    country_name VARCHAR(255) NOT NULL,
    region_id INT,
    -- Add constraint
    CONSTRAINT "country_name_not_empty" CHECK (LENGTH(TRIM(country_name)) >= 0),
    -- Add foreign key references
    FOREIGN KEY (region_id) REFERENCES region(region_id)
);

-- Create `item_type` table
CREATE TABLE item_type (
    item_type_id SERIAL PRIMARY KEY,
    item_type_name VARCHAR(255) NOT NULL,
    -- Add constraint
    CONSTRAINT "item_type_name_not_empty" CHECK (LENGTH(TRIM(item_type_name)) >= 0)
);

-- Create `sales_channel` table
CREATE TABLE sales_channel (
    sales_channel_id SERIAL PRIMARY KEY,
    sales_channel_name VARCHAR(255) NOT NULL,
  -- Add constraint
    CONSTRAINT "channel_name_not_empty" CHECK (LENGTH(TRIM(sales_channel_name)) >= 0)
);

-- Create `order` table
CREATE TABLE order (
    order_id SERIAL PRIMARY KEY,
    order_priority CHAR(1),
    order_date DATE,
    ship_date DATE,
    country_id INT,
    item_type_id INT,
    sales_channel_id INT,
    -- Add foreign key references
    FOREIGN KEY (country_id) REFERENCES country(country_id),
    FOREIGN KEY (item_type_id) REFERENCES item_type(item_type_id),
    FOREIGN KEY (sales_channel_id) REFERENCES sales_channel(sales_channel_id)
);

-- Create `sales_details`
CREATE TABLE sales_detail (
    sales_detail_id SERIAL PRIMARY KEY,
    order_id INT,
    units_sold INT,
    unit_price DECIMAL(10, 2),
    unit_cost DECIMAL(10, 2),
    total_revenue DECIMAL(10, 2),
    total_cost DECIMAL(10, 2),
    total_profit DECIMAL(10, 2),
    -- Add foreign key references
    FOREIGN KEY (order_id) REFERENCES order(order_id)
);