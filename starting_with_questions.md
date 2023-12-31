Answer the following questions and provide the SQL queries used to find the answer.

    
**Question 1: Which cities and countries have the highest level of transaction revenues on the site?**

**SQL Queries:**
```SQL
SELECT 
  COALESCE(city, 'Other') AS city, 
  COALESCE(country, 'Other') AS country, 
  CAST(totaltransactionrevenue AS NUMERIC) AS total_revenue_numeric
FROM all_sessions
WHERE 
  totaltransactionrevenue IS NOT NULL
  AND city IS NOT NULL
  AND city <> ''
  AND country IS NOT NULL
  AND country <> ''
ORDER BY total_revenue_numeric DESC
LIMIT 1;
```

## Answer:
CITY IS NOT AVAILABLE IN DATASET
COUNTRY IS UNITED STATES
TOTALTRANSACTIONREVENUE 1015480000 


**Question 2: What is the average number of products ordered from visitors in each city and country?**


**SQL Queries:**

```SQL
SELECT 
  city, 
  country, 
  ROUND(AVG(productquantity)::numeric, 2) AS average_products_ordered
FROM all_sessions
WHERE productquantity IS NOT NULL
GROUP BY city, country
ORDER BY average_products_ordered DESC
limit 5;
```


**Question 3: Is there any pattern in the types (product categories) of products ordered from visitors in each city and country?**


**SQL Queries:**

```SQL
SELECT 
  COALESCE(NULLIF(city, ''), 'Other') AS city, 
  COALESCE(NULLIF(country, ''), 'Other') AS country, 
  v2productcategory, 
  COUNT(*) AS order_count
FROM all_sessions
WHERE v2productcategory IS NOT NULL
  AND (city IS NOT NULL AND city != '(not set)')
  AND (country IS NOT NULL AND country != '(not set)')
  AND (city IS NOT NULL AND city != 'not available in demo dataset')
  AND (country IS NOT NULL AND country != 'not available in demo dataset')
GROUP BY city, country, v2productcategory
HAVING COUNT(*) > 10
ORDER BY country, city, order_count DESC;
```

## Answer:
In this query, we select the "city," "country," and "v2productcategory" columns, along with the count of orders for each product category (using the COUNT(*) function) from the "all_sessions" table. We filter the results with WHERE v2productcategory IS NOT NULL to consider only rows where the "v2productcategory" is not null.

Next, we use the GROUP BY clause to group the data by "city," "country," and "v2productcategory." This grouping will allow us to calculate the count of orders for each product category within each city and country.

The query also includes additional conditions in the WHERE clause to exclude rows where the city is "(not set)" or country is "(not set)".

Finally, we use the ORDER BY clause to sort the result by "country," "city," and "order_count" in descending order. This will help you view purchases from different cities in each country and identify patterns in purchases across various regions.

The result of this query will give you a detailed breakdown of product category purchases for each city within each country, allowing you to analyze patterns in purchases across different locations.




**Question 4: What is the top-selling product from each city/country? Can we find any pattern worthy of noting in the products sold?**


**SQL Queries:**
```SQL
WITH ranked_products AS (
  SELECT 
    COALESCE(NULLIF(city, ''), 'Other') AS city, 
    COALESCE(NULLIF(country, ''), 'Other') AS country, 
    v2productname, 
    COUNT(*) AS order_count,
    ROW_NUMBER() OVER (PARTITION BY city, country ORDER BY COUNT(*) DESC) AS rn
  FROM all_sessions
  WHERE v2productname IS NOT NULL
    AND (city IS NOT NULL AND city != '(not set)')
    AND (country IS NOT NULL AND country != '(not set)')
	AND (city IS NOT NULL AND city != 'not available in demo dataset')
  	AND (country IS NOT NULL AND country != 'not available in demo dataset')
  GROUP BY city, country, v2productname
)
SELECT city, country, v2productname, order_count
FROM ranked_products
WHERE rn = 1
ORDER BY country, city;
```

## Answer:
In this query, a Common Table Expression (CTE) named "ranked_products" is used to calculate the order count for each product ("v2productname") within each city and country. 
The ROW_NUMBER() function assigns a rank to each product based on its order count, partitioned by city and country. 
The main part of the query then selects the top-selling product from each city and country, along with its order count, by filtering only the rows with a rank of 1 (rn = 1). 
The query excludes rows where the city is "(not set)" or country is "(not set)" to focus on valid city and country information. The results are ordered by country and city, 
enabling the identification of patterns in the most popular products across different regions and providing insights into customer preferences for marketing, 
inventory management, and product strategies.




**Question 5: Can we summarize the impact of revenue generated from each city/country?**

SQL Queries:
```SQL
SELECT city, country, SUM(totaltransactionrevenue::NUMERIC) AS total_revenue, v2productname
FROM all_sessions
WHERE totaltransactionrevenue IS NOT NULL
  AND country IS NOT NULL AND country != '(not set)'
  AND city IS NOT NULL AND city != '(not set)'
GROUP BY city, country,v2productname
ORDER BY total_revenue DESC;
```

## Answer:
Cities from United States generated the largest revenues
Reuseable shopping bag and Google Bongo Cupholder Bluetooth Speaker were to top selling products






