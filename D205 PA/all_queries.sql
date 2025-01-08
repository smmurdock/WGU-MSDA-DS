-- -- View first 100 rows of data from customer table
SELECT *
FROM customer
LIMIT 100;


-- Find the minimum and maximum ages in the customer table
-- SELECT MIN(age) AS min_age, MAX(age) AS max_age
-- FROM customer;


-- Create service table
-- Add to public schema
-- Verify ownership is to postrgres
-- CREATE TABLE public.service (
--  	id SERIAL PRIMARY KEY,
-- 		customer_id VARCHAR(7) NOT NULL REFERENCES customer(customer_id),
--  	internet_service VARCHAR(50) NOT NULL,
--  	phone SMALLINT NOT NULL,
--  	multiple SMALLINT NOT NULL,
--  	online_security SMALLINT NOT NULL,
--  	online_backup SMALLINT NOT NULL,
--  	device_protection SMALLINT NOT NULL,
--  	tech_support SMALLINT NOT NULL
-- );
-- ALTER TABLE public.service
-- OWNER TO postgres;


-- Import Data from CSV to service table


-- Verify data imported to table
-- Query first 100 rows
-- SELECT *
-- FROM service
-- LIMIT 100;


-- Find out how many users are using technical support
-- SELECT SUM(tech_support) AS total_technical_support
-- FROM service;


-- Divide users into age groups:
-- Under 25, 25-34, 35-44, 45-54, 55-64, 65-74, Abovew 75
-- Group by age groups (age_range) and sum how many people in each age range
-- are utilizing technical support
-- What age group is utilizing technical support the most?
-- SELECT SUM(tech_support) AS total_technical_support,
--  	CASE WHEN age < 25 THEN 'Under 25'
--  		 WHEN age BETWEEN 25 AND 34 THEN '25-34'
--  		 WHEN age BETWEEN 35 AND 44 THEN '35-44'
--  		 WHEN age BETWEEN 45 AND 54 THEN '45-54'
--  		 WHEN age BETWEEN 55 AND 64 THEN '55-64'
--  		 WHEN age BETWEEN 65 AND 74 THEN '65-74'
--  		 ELSE 'Above 75'
--  	END AS age_range
--  FROM service
--  INNER JOIN customer
--  ON service.customer_id = customer.customer_id
--  GROUP BY age_range
--  ORDER BY total_technical_support DESC;