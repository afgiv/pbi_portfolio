-- Create the table for loading the raw data
-- Make sure to copy the exact column and data type

BEGIN;

CREATE TABLE IF NOT EXISTS staging.raw_data (
	invoice VARCHAR (100),
	stock_code VARCHAR (100),
	description VARCHAR (100),
	quantity INTEGER,
	invoice_date TIMESTAMP,
	price NUMERIC(10, 2),
	customer_id NUMERIC,
	country TEXT
);

COMMIT;