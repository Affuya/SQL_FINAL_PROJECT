SELECT * FROM all_sessions_filtered
SELECT * FROM analytics
limit 2

SELECT column_name
FROM information_schema.columns
WHERE table_name = 'sales_report';

--=========================
SELECT sku FROM products
ORDER BY visitnumber;
--=================

SELECT userid, COUNT(*) 
	FROM analytics
GROUP BY userid
HAVING COUNT(*) >1;

ALTER TABLE analytics
ADD COLUMN id SERIAL PRIMARY KEY;

ALTER TABLE all_sessions_filtered
ADD COLUMN id SERIAL PRIMARY KEY;

ALTER TABLE sales_report
ADD PRIMARY KEY (productsku);
