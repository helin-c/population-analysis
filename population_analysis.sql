-- Complete each query under its relevant comment: 

-- 1. How many entries in the database are from Africa?
-- 2. What was the total population of Africa in 2010?
-- 3. What is the average population of countries in South America in 2000?
-- 4. What country had the smallest population in 2007?
-- 5. How much has the population of Europe grown from 2000 to 2010?
-- 6. Are there any other queries you think could be more useful to the Kenyan government?


-- 1. How many entries in the database are from Africa?
SELECT COUNT(continent) AS africa_country_count
FROM dbo.countries
WHERE continent = 'Africa';

--Answer Q1: There are 56 entries from Africa in the database

-- 2. What was the total population of Africa in 2010?
SELECT SUM(p.population) AS africa_population_2010
FROM dbo.population_years AS p
INNER JOIN dbo.countries AS c
ON c.id = p.country_id
WHERE c.continent = 'Africa' AND p.year = 2010;

--Answer Q2: The total population of Africa in 2010 was 991 million

-- 3. What is the average population of countries in South America in 2000?
SELECT AVG(p.population) AS avg_population_2000
FROM dbo.population_years AS p
INNER JOIN dbo.countries AS c
ON c.id = p.country_id 
WHERE c.continent = 'South America'
AND p.year = 2000;

-- Answer Q3: Average population of South American countries in 2000 was 24 million

-- 4. What country had the smallest population in 2007?
SELECT TOP 1 c.name, p.population
FROM dbo.population_years AS p
INNER JOIN dbo.countries AS c
ON c.id = p.country_id
WHERE p.year = 2007 AND p.population IS NOT NULL 
ORDER BY p.population ASC;

-- Answer Q4: Bermuda had the smallest population in 2007 (with a 0 in the dataset) 
-- However, multiple countries have a population value of 0 in 2007, which likely
-- indicates missing data. Therefore, the dataset does not uniquely identify a single
-- country with the smallest population.

-- 5. How much has the population of Europe grown from 2000 to 2010?
SELECT SUM(CASE WHEN p.year = 2010 THEN p.population END) -
SUM(CASE WHEN p.year = 2000 THEN p.population END) AS europe_growth
FROM dbo.population_years AS p
INNER JOIN dbo.countries AS c
ON c.id = p.country_id
WHERE c.continent = 'Europe' AND p.year IN (2000, 2010);

-- Answer Q5: (-8) Europe's population decreased by approximately 8 million from 2000 to 2010

-- 6. Are there any other queries you think could be more useful to the Kenyan government?
-- Query 1: Population of Kenya over time
SELECT p.year, p.population
FROM dbo.population_years AS p
INNER JOIN dbo.countries AS c
ON c.id = p.country_id
WHERE c.name = 'Kenya'
ORDER BY p.year;
-- This query shows Kenya's population trend over time (between 2000 and 2010),
-- helping the government understand long-term growth patterns.


-- Query 2: Population growth of African countries from 2000 to 2010
SELECT c.name,
    SUM(CASE WHEN p.year = 2010 THEN p.population END) -
    SUM(CASE WHEN p.year = 2000 THEN p.population END) AS population_growth
FROM dbo.population_years AS p
INNER JOIN dbo.countries AS c
    ON c.id = p.country_id
WHERE c.continent = 'Africa'
  AND p.year IN (2000, 2010)
GROUP BY c.name
ORDER BY population_growth DESC;

-- This query shows African countries with the highest population growth between 
-- 2000 and 2010, which can help Kenya prioritise which countries to trade or '
-- partnership with.