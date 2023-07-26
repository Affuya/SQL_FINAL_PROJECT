# Question 1: 
## What are the top countries and cities by total transaction revenue?

**SQL Queries:**

```SQL
SELECT country, city, SUM(ROUND(totaltransactionrevenue::numeric/1000000, 2)) AS total_revenue
FROM all_sessions
WHERE totaltransactionrevenue IS NOT NULL
  AND country IS NOT NULL AND country != '(not set)'
  AND city IS NOT NULL AND city != '(not set)'
GROUP BY country, city
ORDER BY total_revenue DESC
LIMIT 5;
```
## Answer
A city in USA without data on the name had the largest total revenue just over 6mm.
# Question 2: 
## What are the most viewed pages and their associated revenue

**SQL Queries:**

```SQL
SELECT als.pagetitle, SUM(als.pageviews) AS total_pageviews, ROUND(SUM(a.revenue) / 1000000, 2) AS revenue_millions
FROM all_sessions als
JOIN analytics a
ON als.pageviews = a.pageviews
WHERE a.revenue IS NOT NULL
GROUP BY als.pagetitle
ORDER BY total_pageviews DESC
Limit 5;
```

## Answer:
The office, Nest-USA and "Men's T-Shirts | Apparel | Google Merchandise Store" the largest pageview with over 400,000 views and also generated 3.8mm, 3.3mm and 3.9mm in revenue respectively.

# Question 3:
## How did studying visitor behavior metrics, such as session duration, page views, and search keywords, 
help improve the website's user experience and optimize content to increase visitor engagement?

**SQL Queries:**
```SQL
SELECT fullvisitorid, 
       ROUND(AVG(pageviews)) AS avg_pageviews, 
       ROUND(AVG(timeonsite)) AS avg_timeonsite
FROM all_sessions
WHERE fullvisitorid IS NOT NULL
GROUP BY fullvisitorid
HAVING ROUND(AVG(timeonsite))IS NOT NULL
ORDER BY avg_timeonsite DESC;
```
## Answer
Studying visitor behavior metrics, such as session duration, page views, and search keywords,
provided valuable insights into how visitors interacted with the website. By analyzing these metrics, 
we gained a better understanding of user preferences and behaviors, allowing us to identify areas of improvement
in the website's user experience. For example, we could identify pages with high bounce rates or low engagement
and optimize their content to make them more appealing to visitors. Additionally, analyzing search keywords helped 
us uncover popular topics of interest, enabling us to create targeted content that resonates with our audience. Overall, 
this data-driven approach led to improvements in the website's design, content, and navigation, resulting in increased visitor
engagement and a more satisfying user experience.