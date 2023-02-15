--SELECT *
--FROM SQLPROJECT..CovidDeaths 
--order by 3,4
--SELECT *
--FROM SQLPROJECT..CovidVaccinations 
--order by 3,4
--SELECT location,date,total_cases, new_cases,total_deaths,population
--FROM SQLPROJECT..CovidDeaths 
--order by 1,2

--- comparing the total cases with total deaths
SELECT location,date,total_cases,total_deaths,(total_deaths/total_cases)*100 as DeathPercentage
FROM SQLPROJECT..CovidDeaths 
order by 1,2

SELECT location,date,total_cases,total_deaths,(total_deaths/total_cases)*100 as DeathPercentage
FROM SQLPROJECT..CovidDeaths 
WHERE location like '%Nigeria%'
order by 1,2

--percentage of population with covid
SELECT location,date,population,total_cases,(total_cases/population)*100 as CovidPercentage
FROM SQLPROJECT..CovidDeaths 
WHERE location like '%Nigeria%'
order by 1,2
--- i will continue with Sweden because Nigeria had a minor case
SELECT location,date,population,total_cases,(total_cases/population)*100 as CovidPercentage
FROM SQLPROJECT..CovidDeaths 
WHERE location like '%Sweden%'
order by 1,2
----lets check the country with the maximum number of covid cases
SELECT location,population, MAX(total_cases) as HighestInfectionCount,
max((total_cases/population))*100 as PercentagePopulationInfected
from SQLPROJECT..CovidDeaths
GROUP BY location, population
ORDER BY PercentagePopulationInfected DESC

--- SHOWING COUNTRIES WITH HIGHEST DEATHS CASES
SELECT location, max(cast(total_deaths as int)) TotalDeathCount
from SQLPROJECT..CovidDeaths
where continent is not null
GROUP BY location
ORDER BY TotalDeathCount DESC

---- let's look at the data by continents
SELECT continent, max(cast(total_deaths as int)) TotalDeathCount
from SQLPROJECT..CovidDeaths
where continent is not null
GROUP BY continent
ORDER BY TotalDeathCount DESC

--- GLOBAL FIGURES
SELECT date, SUM(new_cases) as GlobalnewCases, SUM(CAST(new_deaths as int)) as GlobalnewDeath,
SUM(CAST(new_deaths as int))/SUM(new_cases)*100 AS GlobalDeathPercentage
FROM SQLPROJECT..CovidDeaths 
---WHERE location like '%Nigeria%'
where continent is not null
GROUP BY date
order by 1,2


---moving the tables together
SELECT SUM(new_cases) as GlobalnewCases, SUM(CAST(new_deaths as int)) as GlobalnewDeath,
SUM(CAST(new_deaths as int))/SUM(new_cases)*100 AS GlobalDeathPercentage
FROM SQLPROJECT..CovidDeaths 
---WHERE location like '%Nigeria%'
where continent is not null
--GROUP BY date
order by 1,2


---working on the CovidVaccination data
select *
from SQLPROJECT..CovidDeaths dea
 JOIN SQLPROJECT..CovidVaccinations vac
 on dea.location = vac.location
 and dea.date = vac.date

 select dea.continent,dea.location,dea.date, dea.population, vac.new_vaccinations
 from SQLPROJECT..CovidDeaths dea
 JOIN SQLPROJECT..CovidVaccinations vac
 on dea.location = vac.location
 and dea.date = vac.date
 where dea.continent is not null
 order by 1,2,3


 select dea.continent,dea.location,dea.date, dea.population, vac.new_vaccinations,
 sum(cast(vac.new_vaccinations as int)) OVER(Partition by dea.location order by dea.location, dea.date)
 as RollingPeopleVaccination
 from SQLPROJECT..CovidDeaths dea
 JOIN SQLPROJECT..CovidVaccinations vac
 on dea.location = vac.location
 and dea.date = vac.date
 where dea.continent is not null
 order by 1,2,3


















