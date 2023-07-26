# What issues will you address by cleaning the data?
Based on the data provided some of the issues that may be addressed by cleaning the data include:

1. Missing Values: Cleaning the data will involve handling missing values in columns such as 
"city," "country," "productsku," "unit_price," etc. By addressing missing values, we can ensure 
the integrity of the analysis and prevent potential errors in calculations and reporting.

2. Data Type Consistency: Ensuring that the data types are consistent across columns will be important. 
For example, verifying that numeric columns like "totaltransactionrevenue," "unit_price," and "total_ordered" have the correct data types 
(e.g., NUMERIC or INTEGER) for accurate calculations.

3. Data Validity: Cleaning the data will involve checking for valid values in categorical columns, 
such as "channelgrouping," "productsku," and "country." We may need to ensure that these columns contain valid values and handle any inconsistencies or misspellings.

4. Duplicates: Identifying and handling duplicate rows in the tables will help avoid double-counting and improve the accuracy of aggregate calculations.

5. Data Formatting: Standardizing data formats, such as date formats in the "time" and "date" columns, will make it easier to perform time-based analysis and comparisons.

6. Referential Integrity: Ensuring that foreign key relationships between tables (if applicable) 
are maintained and consistent will be crucial to avoid data inconsistencies and errors in queries.

7. Data Normalization: If there are redundancies in the data or denormalized data, normalization techniques can be applied to reduce data duplication and improve data integrity.

Queries:
# Below, provide the SQL queries you used to clean your data.

## Update "city" and "country" columns with 'Other' where NULL or '(not set)'
```SQL
UPDATE all_sessions
SET city = 'Other'
WHERE city IS NULL OR city = '(not set)';
```

```SQL
UPDATE all_sessions
SET country = 'Other'
WHERE country IS NULL OR country = '(not set)';
```
## Convert "unit_price" column to NUMERIC data type
```SQL
ALTER TABLE analytics
ALTER COLUMN unit_price TYPE NUMERIC;
```
## Convert "total_ordered" column to INTEGER data type
```SQL
ALTER TABLE sales_by_sku
ALTER COLUMN total_ordered TYPE INTEGER;
```

## Convert "unit_price" column to NUMERIC data type
```SQL
ALTER TABLE analytics
ALTER COLUMN unit_price TYPE NUMERIC;
```

## Convert "total_ordered" column to INTEGER data type
```SQL
ALTER TABLE sales_by_sku
ALTER COLUMN total_ordered TYPE INTEGER;
```
## Identify duplicate rows based on all columns and assign a row number
```SQL
WITH duplicate_rows AS (
    SELECT *,
           ROW_NUMBER() OVER (PARTITION BY fullvisitorid, channelgrouping, time, country, city, 
                              totaltransactionrevenue, transactions, pageviews, timeonsite, date,
                              pagetitle, searchkeyword, pagepathlevel1
                             ORDER BY fullvisitorid) AS rn
    FROM all_sessions
)
-- Delete duplicate rows, keeping only the first occurrence (row number = 1)
DELETE FROM all_sessions
WHERE (fullvisitorid, channelgrouping, time, country, city, 
       totaltransactionrevenue, transactions, pageviews, timeonsite, date,
       pagetitle, searchkeyword, pagepathlevel1) IN (
           SELECT fullvisitorid, channelgrouping, time, country, city, 
                  totaltransactionrevenue, transactions, pageviews, timeonsite, date,
                  pagetitle, searchkeyword, pagepathlevel1
           FROM duplicate_rows
           WHERE rn > 1
       );
```

