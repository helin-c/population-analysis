# Government of Kenya: Global Population & Trade Strategy Analysis

## 🌍 Project Overview
This project was completed as an individual SQL technical delivery task. The scenario involves acting as a Data Analyst for the Government of Kenya. The Kenyan government is currently reassessing its trade strategies with various nations and requires an understanding of how the global population is changing across continents to better target their diplomatic efforts. 

The objective was to write repeatable SQL queries to answer specific demographic questions and provide actionable business insights.

## 🛠️ Tools & Techniques
* **SQL Server (T-SQL):** Used for database querying, data manipulation, and extraction from a provided countries database.
* **Techniques Used:** `JOIN`s, Aggregate Functions (`SUM`, `AVG`, `COUNT`), Conditional Aggregation (`CASE WHEN`), Filtering (`WHERE`, `IS NOT NULL`), and Sorting (`ORDER BY`).

## 📊 Key Queries & Insights

### 1. African Representation in the Database
**Question:** How many entries in the database are from Africa? 
```sql
SELECT COUNT(continent) AS africa_country_count
FROM dbo.countries
WHERE continent = 'Africa';
```
**Insight:** There are 56 entries from Africa in the database.

### 2. Total African Population (2010)
**Question:** What was the total population of Africa in 2010? 
```sql
SELECT SUM(p.population) AS africa_population_2010
FROM dbo.population_years AS p
INNER JOIN dbo.countries AS c
  ON c.id = p.country_id
WHERE c.continent = 'Africa' AND p.year = 2010;
```
**Insight:** The total population of Africa in 2010 was 991 million.

### 3. South American Average Population (2000)
**Question:** What is the average population of countries in South America in 2000? 
```sql
SELECT AVG(p.population) AS avg_population_2000
FROM dbo.population_years AS p
INNER JOIN dbo.countries AS c
  ON c.id = p.country_id
WHERE c.continent = 'South America' AND p.year = 2000;
```
**Insight:** The average population of South American countries in 2000 was 24 million.

### 4. Smallest Recorded Population (2007)
**Question:** What country had the smallest population in 2007? 
```sql
SELECT TOP 1 c.name, p.population
FROM dbo.population_years AS p
INNER JOIN dbo.countries AS c
  ON c.id = p.country_id
WHERE p.year = 2007 AND p.population IS NOT NULL
ORDER BY p.population ASC;
```
**Insight:** Bermuda had the smallest population in 2007. *(Note: The dataset records a 0 for this value, which likely indicates missing or incomplete data rather than a true zero population).*

### 5. European Population Growth (2000-2010)
**Question:** How much has the population of Europe grown from 2000 to 2010? 
```sql
SELECT 
  SUM(CASE WHEN p.year = 2010 THEN p.population END) - 
  SUM(CASE WHEN p.year = 2000 THEN p.population END) AS europe_growth
FROM dbo.population_years AS p
INNER JOIN dbo.countries AS c
  ON c.id = p.country_id
WHERE c.continent = 'Europe' AND p.year IN (2000, 2010);
```
**Insight:** Europe experienced a population *decline*. The population decreased by approximately 8 million people between 2000 and 2010.

### 6. Strategic Business Recommendations
To provide further value to the Kenyan Government, I proactively generated two additional queries to assist with trade strategy:

**A. Kenya's Population Trend**
```sql
SELECT p.year, p.population
FROM dbo.population_years AS p
INNER JOIN dbo.countries AS c
  ON c.id = p.country_id
WHERE c.name = 'Kenya'
ORDER BY p.year;
```
**Insight:** This allows the government to map its own internal growth patterns against global trends between 2000 and 2010. 

**B. Top Emerging African Markets (Growth 2000-2010)**
```sql
SELECT c.name,
  SUM(CASE WHEN p.year = 2010 THEN p.population END) - 
  SUM(CASE WHEN p.year = 2000 THEN p.population END) AS population_growth
FROM dbo.population_years AS p
INNER JOIN dbo.countries AS c
  ON c.id = p.country_id
WHERE c.continent = 'Africa' AND p.year IN (2000, 2010)
GROUP BY c.name
ORDER BY population_growth DESC;
```
**Insight:** This query identifies which African nations are growing the fastest. For instance, Nigeria saw a growth of 29 million, followed by Ethiopia (24 million) and Congo (19 million). Kenya can prioritize these rapidly expanding markets for future trade partnerships.

## 📂 How to Use This Repository
* The uploaded `.sql` file contains the raw SQL scripts used for this analysis. 
* To replicate this work, the scripts can be executed in any SQL Server Management Studio (SSMS) environment containing the appropriate countries and population schema.
