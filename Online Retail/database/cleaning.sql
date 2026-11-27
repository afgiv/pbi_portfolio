-- Check the invoice column

SELECT DISTINCT(invoice) FROM staging.dedup;
-- There are some with 'C' before the number

SELECT * FROM staging.dedup
WHERE invoice LIKE 'C%';
-- Looking at the quantity column, all invoice numbers with starting C have their quantity at negative
-- Means the transaction is cancelled or the item was returned
-- In order to address this, we will remove the C in the invoice column and add another column is_cancelled as bool
-- Trim first the column of invoice to ensure safe insertion

BEGIN;

UPDATE staging.dedup
SET invoice = UPPER(TRIM(invoice));

COMMIT;

BEGIN;

ALTER TABLE staging.dedup
ADD COLUMN is_cancelled BOOLEAN;

SELECT is_cancelled FROM staging.dedup;

COMMIT;

-- Insert values in is_cancelled

BEGIN;

UPDATE staging.dedup
SET is_cancelled = 
CASE WHEN invoice LIKE 'C%' THEN TRUE ELSE FALSE END;

-- Check the values if correct

SELECT invoice, is_cancelled
FROM staging.dedup
WHERE invoice NOT LIKE 'C%' AND is_cancelled = true; -- 0

SELECT invoice, is_cancelled
FROM staging.dedup
WHERE invoice LIKE 'C%' AND is_cancelled = false; -- 0

COMMIT;

-- We can row remove the C from the invoice
BEGIN;

UPDATE staging.dedup
SET invoice = REPLACE(invoice, 'C', '')
WHERE invoice LIKE 'C%';

SELECT invoice FROM staging.dedup
WHERE invoice LIKE 'C%'; -- 0

COMMIT;

SELECT DISTINCT * FROM staging.dedup;

-- We can now change the data type of invoice column to INT to enforce data restriction
BEGIN;

ALTER TABLE staging.dedup
ALTER COLUMN invoice TYPE INT
USING invoice::integer; -- ERROR:  invalid input syntax for type integer: "A506401" 

ROLLBACK;

-- There are still issues in the invoice column that we did not find

SELECT DISTINCT * FROM staging.dedup
WHERE invoice LIKE 'A%';

-- Notice A% are bad debt and so we will just flag them in another column
BEGIN;

ALTER TABLE staging.dedup
ADD COLUMN is_bad_debt BOOL;

UPDATE staging.dedup
SET is_bad_debt = CASE
WHEN invoice LIKE 'A%' THEN TRUE ELSE FALSE END;

SELECT DISTINCT * FROM staging.dedup
WHERE invoice LIKE 'A%';

SELECT DISTINCT * FROM staging.dedup
WHERE invoice NOT LIKE 'A%' AND is_bad_debt = TRUE; -- 0

-- Remove the A's in the invoice
UPDATE staging.dedup
SET invoice = REPLACE (invoice, 'A', '')
WHERE invoice LIKE 'A%';

SELECT DISTINCT * FROM staging.dedup
WHERE invoice LIKE 'A%'; -- 0

COMMIT;

-- Try to change the data type of invoice again
BEGIN;

ALTER TABLE staging.dedup
ALTER COLUMN invoice TYPE INT
USING invoice::integer;

COMMIT;

-- Check whether the invoice numbering is standard

SELECT DISTINCT invoice FROM staging.dedup
GROUP BY invoice
HAVING LENGTH(invoice::TEXT) > 6;

SELECT DISTINCT invoice FROM staging.dedup
GROUP BY invoice
HAVING LENGTH(invoice::TEXT) < 6;

-- Check the stock_code column together with description to help us understand what the code means
SELECT DISTINCT stock_code, description FROM staging.dedup;