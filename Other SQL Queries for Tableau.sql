
SELECT dea.continent, dea.location, dea.date, dea.population,
       MAX(vac.total_vaccinations) as RollingPeopleVaccinated
FROM PortfolioProject.CovidDeaths dea
JOIN PortfolioProject.CovidVaccinations vac
	ON dea.location = vac.location
	AND dea.date = vac.date
WHERE dea.continent IS NOT NULL 
GROUP BY dea.continent, dea.location, dea.date, dea.population
ORDER BY 1, 2, 3;


SELECT SUM(new_cases) as total_cases, SUM(CAST(new_deaths as SIGNED)) as total_deaths,
       SUM(CAST(new_deaths as SIGNED))/SUM(new_cases)*100 as DeathPercentage
FROM PortfolioProject.CovidDeaths
WHERE continent IS NOT NULL 
ORDER BY 1, 2;


SELECT location, SUM(CAST(new_deaths as SIGNED)) as TotalDeathCount
FROM PortfolioProject.CovidDeaths
WHERE continent IS NULL 
AND location NOT IN ('World', 'European Union', 'International')
GROUP BY location
ORDER BY TotalDeathCount DESC;



SELECT Location, Population, MAX(total_cases) as HighestInfectionCount,
       MAX((total_cases/Population))*100 as PercentPopulationInfected
FROM PortfolioProject.CovidDeaths
GROUP BY Location, Population
ORDER BY PercentPopulationInfected DESC;


SELECT Location, date, population, total_cases, total_deaths
FROM PortfolioProject.CovidDeaths
WHERE continent IS NOT NULL 
ORDER BY 1, 2;


WITH PopvsVac (Continent, Location, Date, Population, New_Vaccinations, RollingPeopleVaccinated)
AS
(
    SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
           SUM(CAST(vac.new_vaccinations AS SIGNED)) OVER (PARTITION BY dea.Location ORDER BY dea.location, dea.Date) as RollingPeopleVaccinated
    FROM PortfolioProject.CovidDeaths dea
    JOIN PortfolioProject.CovidVaccinations vac
        ON dea.location = vac.location
        AND dea.date = vac.date
    WHERE dea.continent IS NOT NULL 
)
SELECT *, (RollingPeopleVaccinated/Population)*100 as PercentPeopleVaccinated
FROM PopvsVac;


SELECT Location, Population, date, MAX(total_cases) as HighestInfectionCount,
       MAX((total_cases/Population))*100 as PercentPopulationInfected
FROM PortfolioProject.CovidDeaths
GROUP BY Location, Population, date
ORDER BY PercentPopulationInfected DESC;



