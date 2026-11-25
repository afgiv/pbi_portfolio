-- Clean the data
-- Remove duplicates first before going for column to column cleaning

-- Check for duplicates

SELECT invoice, stock_code, description, quantity, invoice_date, price, customer_id, country, COUNT(*) AS dup_count
FROM staging.raw_data
GROUP BY invoice, stock_code, description, quantity, invoice_date, price, customer_id, country
HAVING COUNT(*) > 1; -- 32907 duplicate rows

-- In order to safely delete the duplicate rows, we will create another table and insert the data along with a column row_num
-- row_num column will be an aggregation using ROW_NUMBER OVER PARTITION BY and delete those greater than 1

CREATE TABLE IF NOT EXISTS dedup;

BEGIN;

INSERT INTO dedup
	SELECT invoice, stock_code, description, quantity, invoice_date, price, customer_id, country,
	ROW_NUMBER OVER (PARTITION BY
	invoice, stock_code, description, quantity, invoice_date, price, customer_id, country) AS row_num
	FROM staging.raw_data;

-- Check the dedup table
SELECT * FROM staging.dedup;

-- If correct, we can commit else rollback

COMMIT;

-- Now we can delete any row_num greater than 1

BEGIN;

DELETE FROM staging.dedup
WHERE row_num > 1; -- 34335 deleted rows

COMMIT;

-- Check if there are any duplicates in the dedup table
SELECT invoice, stock_code, description, quantity, invoice_date, price, customer_id, country, COUNT(*) AS dup_count
FROM staging.dedup
GROUP BY invoice, stock_code, description, quantity, invoice_date, price, customer_id, country
HAVING COUNT(*) > 1; -- None

-- We can now safely drop the row_num column

BEGIN;

ALTER TABLE staging.dedup
DROP COLUMN row_num;

COMMIT;