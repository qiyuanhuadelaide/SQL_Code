-- Select the oldest and newest founding years from the businesses table
SELECT min(year_founded),max(year_founded)
FROM businesses;
-- Select all columns from businesses where the founding year was before 1000
-- Arrange the results from oldest to newest
SELECT *
FROM businesses
WHERE year_founded < 1000
ORDER BY year_founded;
-- Select business name, founding year, and country code from businesses; and category from categories
-- where the founding year was before 1000, arranged from oldest to newest
SELECT business, year_founded, country_code, category
FROM businesses
JOIN categories
ON businesses.category_code=  categories.category_code
WHERE year_founded < 1000
ORDER BY year_founded;
-- Select the category and count of category (as "n")
-- arranged by descending count, limited to 10 most common categories

SELECT cat.category, COUNT(cat.category) AS n
    FROM businesses AS bus
    INNER JOIN categories AS cat
        ON bus.category_code = cat.category_code
    GROUP BY cat.category
    ORDER BY n DESC
    LIMIT 10;
-- Select the oldest founding year (as "oldest") from businesses, 
-- and continent from countries
-- for each continent, ordered from oldest to newest

SELECT MIN(bus.year_founded) as oldest, cnt.continent
    FROM businesses AS bus
    INNER JOIN countries as cnt
        ON bus.country_code = cnt.country_code
    GROUP BY continent
    ORDER BY oldest;


-- Select the business, founding year, category, country, and continent
SELECT business, year_founded, category, country, continent
FROM businesses b 
JOIN categories c ON b.category_code = c.category_code
JOIN countries cnt ON b.country_code = cnt.country_code;

-- Count the number of businesses in each continent and category

SELECT cnt.continent, cat.category, COUNT(*) AS n
    FROM businesses AS bus
    INNER JOIN categories as cat
        ON bus.category_code = cat.category_code
    INNER JOIN countries as cnt
        ON bus.country_code = cnt.country_code
    GROUP BY cnt.continent, cat.category;
	
-- Repeat that previous query, filtering for results having a count greater than 5

SELECT cnt.continent, cat.category, COUNT(*) AS n
    FROM businesses AS bus
    INNER JOIN categories as cat
        ON bus.category_code = cat.category_code
    INNER JOIN countries as cnt
        ON bus.country_code = cnt.country_code
    GROUP BY cnt.continent, cat.category
    HAVING COUNT(*)> 5
    ORDER BY n DESC;
