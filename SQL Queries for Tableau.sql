/*

Queries used for Tableau Visualization Project

*/

USE PortfolioProject;

-- 1. Calculate total cases, total deaths, and death percentage for each location with non-null continents.
SELECT 
    SUM(new_cases) AS total_cases, 
    SUM(CAST(new_deaths AS SIGNED)) AS total_deaths, 
    SUM(CAST(new_deaths AS SIGNED)) / SUM(new_cases) * 100 AS DeathPercentage
FROM PortfolioProject.covid_deaths
WHERE continent IS NOT NULL
ORDER BY 1, 2;



-- Just a double check based off the data provided
-- numbers are extremely close so we will keep them - The Second includes "International"  Location


-- Select SUM(new_cases) as total_cases, SUM(cast(new_deaths as int)) as total_deaths, SUM(cast(new_deaths as int))/SUM(New_Cases)*100 as DeathPercentage
-- From PortfolioProject..CovidDeaths
-- Where location like '%states%'
-- where location = 'World'
-- roup By date
-- order by 1,2


-- 2. Calculate total death count for locations with excluding 'World', 'European Union', and 'International'.
SELECT
    location,
    SUM(CAST(new_deaths AS SIGNED)) AS TotalDeathCount
FROM
    PortfolioProject.covid_deaths
WHERE
	location NOT IN ('World', 'European Union', 'International')
GROUP BY
    location
ORDER BY
    SUM(CAST(new_deaths AS SIGNED)) DESC;


-- 2.0 Calculate total death count for continent with excluding 'World', 'European Union', and 'International'.

SELECT
    continent as Location,
    SUM(CAST(new_deaths AS SIGNED)) AS TotalDeathCount
FROM
    PortfolioProject.covid_deaths
WHERE
    continent NOT IN ('World', 'European Union', 'International')
GROUP BY
    continent
ORDER BY
    SUM(CAST(new_deaths AS SIGNED)) DESC;



-- 3. Calculate highest infection count and percent population infected for each location.
SELECT 
    Location, 
    Population, 
    MAX(total_cases) AS HighestInfectionCount,  
    MAX((total_cases / Population)) * 100 AS PercentPopulationInfected
FROM PortfolioProject.covid_deaths
GROUP BY Location, Population
ORDER BY PercentPopulationInfected DESC;



-- 4. Calculate highest infection count and percent population infected for each location by date.
SELECT 
    Location, 
    Population, 
    date, 
    MAX(total_cases) AS HighestInfectionCount,  
    MAX((total_cases / Population)) * 100 AS PercentPopulationInfected
FROM PortfolioProject.covid_deaths
GROUP BY Location, Population, date
ORDER BY PercentPopulationInfected DESC;

/* The query you provided calculates the highest infection count and the percent population infected for each location (countries) 
for all dates in the "PortfolioProject.covid_deaths" table. If you want to restrict the results to specific countries such as 
India, United States, China, and the United Kingdom, you can use a WHERE clause to filter the data accordingly. */
SELECT 
    Location, 
    Population, 
    date, 
    MAX(total_cases) AS HighestInfectionCount,  
    MAX((total_cases / Population)) * 100 AS PercentPopulationInfected
FROM PortfolioProject.covid_deaths
WHERE Location IN ('India', 'United States', 'China', 'United Kingdom')
GROUP BY Location, Population, date
ORDER BY Location, date;

