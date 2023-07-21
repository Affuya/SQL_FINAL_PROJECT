SELECT id FROM all_sessions_filtered;
-- Establish relationship between all_sessions_filtered and analytics
ALTER TABLE analytics
ADD FOREIGN KEY (id) REFERENCES all_sessions_filtered (id);

-- Establish relationship between all_sessions_filtered and sales_report
ALTER TABLE sales_report
ADD FOREIGN KEY (productsku) REFERENCES all_sessions_filtered (id);

-- Establish relationship between sales_report and sales_by_sku
ALTER TABLE sales_by_sku
ADD FOREIGN KEY (productsku) REFERENCES sales_report (productsku);

-- Establish relationship between sales_by_sku and products
ALTER TABLE products
ADD FOREIGN KEY (productsku) REFERENCES sales_by_sku (productsku);

SELECT productsku, count(1) AS total_counts FROM all_sessions
GROUP BY productsku
ORDER BY total_counts DESC
limit 100;

SELECT * FROM analytics 
WHERE units_sold IS NOT NULL
limit 100;

SELECT productrevenue, itemquantity, visitid, productprice, itemrevenue,transactionid, transactionrevenue, productquantity, totaltransactionrevenue FROM all_sessions
WHERE transactionid IS NOT NULL
ORDER BY transactionid
limit 100;

SELECT * FROM all_sessions
WHERE transactionid IS NOT NULL
limit 100;

SELECT transactions
FROM all_sessions
WHERE transactionid IS NOT NULL
limit 100;

SELECT * FROM analytics
limit 100;

SELECT transactionid, COUNT(1) AS total_counts
FROM all_sessions
WHERE transactionid IS NOT NULL
GROUP BY (1)
ORDER BY total_counts DESC;

SELECT COUNT(1) FROM all_sessions
WHERE transactionrevenue IS NOT NULL;

SELECT productrevenue, visitid, productprice /1000000 AS product_price, transactionid, totaltransactionrevenue
FROM all_sessions
WHERE transactionid IS NOT NULL
ORDER BY transactionid
limit 100;

SELECT city, country, totaltransactionrevenue AS TotalTransactionRevenue
FROM all_sessions
WHERE transactionid IS NOT NULL
ORDER BY totaltransactionrevenue DESC
LIMIT 1;

SELECT city, country, CAST(totaltransactionrevenue/1000000 AS INTEGER) AS TotalTransactionRevenue
FROM all_sessions
WHERE transactionid IS NOT NULL
ORDER BY totaltransactionrevenue DESC
LIMIT 1;
-- trying to divide the totaltransactionrevenue column by 1000000 changes the outcome of the result
SELECT city, country, (totaltransactionrevenue::NUMERIC / 1000000) AS TotalTransactionRevenue
FROM all_sessions
WHERE transactionid IS NOT NULL
ORDER BY totaltransactionrevenue DESC
LIMIT 1;
