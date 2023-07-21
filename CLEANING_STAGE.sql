-- Check list of all tables
SELECT table_name
FROM information_schema.tables
WHERE table_schema = 'public';

-- Identify Data Issues
-- Identify the specific data issues or inconsistencies that need to be addressed. 
-- Common issues include missing values, duplicates, incorrect data types, 
-- and formatting problems

SELECT * FROM all_sessions;
SELECT COUNT(*) AS null_count, column_name
FROM your_table
WHERE column_name IS NULL
GROUP BY column_name;


SELECT column_name
FROM information_schema.columns
WHERE table_name = 'all_sessions' AND is_nullable = 'YES';

SELECT COUNT(*) FROM all_sessions;

SELECT
	fullvisitorid,
	channelgrouping,
	time,
	country,
	city,
	totaltransactionrevenue,
	pageviews,
	timeonsite,
	date,
	pagetitle,
	searchkeyword,
	pagepathlevel1
FROM all_sessions;


	