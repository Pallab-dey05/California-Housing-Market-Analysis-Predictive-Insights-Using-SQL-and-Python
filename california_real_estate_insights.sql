-- Calirfornia Real Estate Insights

DROP TABLE IF EXISTS insights;
CREATE TABLE insights
(
	longitude float,
	latitude float,
	housing_median_age int,
	total_rooms	int,
	total_bedrooms int,
	population int,
	households int,
	median_income float,
	median_house_value int,
	ocean_proximity varchar(100)
);

SELECT * FROM insights;

-- Leverage longitude-based segmentation of housing data to reveal location-driven market trends

SELECT
	*
FROM insights
ORDER BY longitude DESC;

-- Business Problem Statements & Data-Driven Analytical Solutions

-- 1. Assess median house values across latitude–longitude regions to identify geographic pricing patterns.

SELECT 
    ROUND(latitude::numeric, 1) AS lat_region,
    ROUND(longitude::numeric, 1) AS long_region,
    AVG(median_house_value) AS avg_house_value
FROM insights
GROUP BY 
    ROUND(latitude::numeric, 1),					-- Geographic Pricing Patterns
    ROUND(longitude::numeric, 1)
ORDER BY avg_house_value DESC;

-- 2. Evaluate the impact of median income on housing prices across neighborhoods.

SELECT 
    AVG(median_income) AS avg_income,
    AVG(median_house_value) AS avg_house_value     		-- Income vs House Value
FROM insights;

-- 3. Assess the impact of ocean proximity on housing prices and regional market demand.

SELECT 
    ocean_proximity,
    AVG(median_house_value) AS avg_value
FROM insights											-- Ocean Proximity Impact
GROUP BY ocean_proximity
ORDER BY avg_value DESC;

-- 4. Evaluate how neighborhood age influences property values across the housing market.

SELECT 
    housing_median_age,
    AVG(median_house_value) AS avg_value				-- Housing Age Influence
FROM insights
GROUP BY housing_median_age
ORDER BY housing_median_age;


-- 5. Analyze the impact of population density on housing prices across regions.

SELECT 
    population,
    AVG(median_house_value) AS avg_value				-- Population vs Price
FROM insights
GROUP BY population
ORDER BY population;

-- 6. Assess how the number of households influences median housing prices.

SELECT 
    households,
    AVG(median_house_value) AS avg_value				-- Households vs Price
FROM insights
GROUP BY households
ORDER BY households;

-- 7. Evaluate whether higher average room counts are associated with increased property values.

SELECT 
    total_rooms,
    AVG(median_house_value) AS avg_value
FROM insights											-- Rooms vs Price
GROUP BY total_rooms
ORDER BY total_rooms;

-- 8. Analyze how the bedroom-to-room ratio influences housing price patterns and property valuation.

SELECT 
    (total_bedrooms::float / total_rooms) AS bedroom_ratio,
    AVG(median_house_value) AS avg_value						
FROM insights															-- Bedroom-to-Room Ratio
GROUP BY bedroom_ratio
ORDER BY bedroom_ratio;

-- 9. Segment neighborhoods into market tiers based on pricing and income levels to identify distinct housing market segments.

SELECT 
    CASE 
        WHEN median_house_value < 150000 THEN 'Low'
        WHEN median_house_value BETWEEN 150000 AND 350000 THEN 'Mid'
        ELSE 'High'
    END AS price_segment,												-- Market Segmentation (Price Tiers)
    COUNT(*) AS total_properties
FROM insights
GROUP BY price_segment;


-- 10. Identify premium housing markets by analyzing geographic areas with consistently high property values and income levels.

SELECT 
    latitude, longitude,
    AVG(median_house_value) AS avg_value
FROM insights											-- Premium Markets
GROUP BY latitude, longitude
ORDER BY avg_value DESC
LIMIT 10;


-- 11. Detect potentially undervalued markets where housing prices remain low despite moderate or high income levels.

SELECT *
FROM insights
WHERE median_income > 5								-- Undervalued Markets
AND median_house_value < 200000;


-- 12. Evaluate the relationship between population per household and housing prices to understand urban density effects.

SELECT 
    (population::float / households) AS ppl_per_household,
    AVG(median_house_value) AS avg_value
FROM insights
GROUP BY ppl_per_household							-- Population per Household
ORDER BY ppl_per_household;


-- 13. Identify price anomalies by detecting properties significantly overvalued or undervalued relative to market indicators.

SELECT *
FROM insights
WHERE median_house_value > (
    SELECT AVG(median_house_value) + 2 * STDDEV(median_house_value)			-- Price Outliers
    FROM insights
);


-- 14. Assess how neighborhood age correlates with population trends and property value distribution.

SELECT 
    housing_median_age,
    AVG(population) AS avg_population,
    AVG(median_house_value) AS avg_value			-- Age vs Population & Price
FROM insights
GROUP BY housing_median_age
ORDER BY housing_median_age;


-- 15. Determine the key drivers of housing prices by analyzing the influence of income, property size, population, age, and location.

SELECT 
    CORR(median_income, median_house_value) AS income_corr,
    CORR(total_rooms, median_house_value) AS rooms_corr,
    CORR(population, median_house_value) AS population_corr,			-- Key Price Drivers
    CORR(housing_median_age, median_house_value) AS age_corr
FROM insights;




