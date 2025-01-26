SELECT *
FROM PortfolioProject..CovidDeath
Where continent is not null
Order by 3,4

SELECT *
FROM PortfolioProject..CovidVaccinations
Order by 3,4


--Select Data that we are going to be using.

Select Location, date, total_cases, new_cases, total_deaths, population
From PortfolioProject..CovidDeath
Order by 1,2

-- Looking at Total Cases vs Total Deaths

Select Location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as DeathPercentage
From PortfolioProject..CovidDeath
Where Location like '%states%'
Order by 1,2
--Shows the likelihood of dying if you contract covid in your country
--Now add population to above query - to get total deaths by population
Select Location, date, population, total_cases, total_deaths
From PortfolioProject..CovidDeath
--Where location like '%states%'
where continent is not null 
order by 1,2


--Looking at the Total Cases vs Population
Select Location, date, population, total_cases, (total_cases/population)*100 as PercentPopulationInfected
From PortfolioProject..CovidDeath
Where Location like '%states%'
Order by 1,2
--Shows what percentage of population got Covid

--What countries with highest infections rate compared to population
Select Location, population, MAX(total_cases) as HighestInfectionCount, Max((total_cases/population))*100 as PercentPopulationInfected
From PortfolioProject..CovidDeath
--Where Location like '%states%'
Group by Location, population
Order by PercentPopulationInfected desc

--Shows countries with the highest death count per population
Select Location, MAX(cast(total_deaths as int)) as TotalDeathCount
From PortfolioProject..CovidDeath
--Where Location like '%states%'
Where continent is not null
Group by Location
Order by TotalDeathCount desc

--LETS BREAK THE ABOVE DOWN BY CONTINENT
--Showing the continents with the highest death counts
Select continent, MAX(cast(total_deaths as int)) as TotalDeathCount
From PortfolioProject..CovidDeath
--Where Location like '%states%'
Where continent is not null
Group by continent
Order by TotalDeathCount desc

--Group above queries by continent (replace location with continent)

--CALCULATE EVRYTHING ACROSS THE WORLD
--GLOBAL NUMBERS
Select date, SUM(new_cases) as total_cases, SUM(cast(new_deaths as int)) as total_deaths, SUM(cast(new_deaths as int))/SUM(New_cases)*100 as DeathPercentage
From PortfolioProject..CovidDeath
--Where Location like '%states%'
Where continent is not null
Group by date
Order by 1,2


--Looking at Total Population vs Vaccinations
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(Cast(vac.new_vaccinations as bigint)) OVER (Partition by dea.location Order by dea.location, cast(
dea.date as datetime)) as RollingPeopleVaccinated
FROM PortfolioProject..CovidDeath dea
Join PortfolioProject..CovidVaccinations vac
	On dea.location = vac.location
	and dea.date = vac.date
Where dea.continent is not null
Order by 2,3

--Total population vs Rolling People Vaccinated
Select dea.continent, dea.location, dea.date, dea.population
, MAX(vac.total_vaccinations) as RollingPeopleVaccinated
--, (RollingPeopleVaccinated/population)*100
From PortfolioProject..CovidDeath dea
Join PortfolioProject..CovidVaccinations vac
	On dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null 
group by dea.continent, dea.location, dea.date, dea.population
order by 1,2,3

--Total cases vs Total deaths Percentage (Visualize the data)
Select SUM(new_cases) as total_cases, SUM(cast(new_deaths as int)) as total_deaths, SUM(cast(new_deaths as int))/SUM(New_Cases)*100 as DeathPercentage
From PortfolioProject..CovidDeath
--Where location like '%states%'
where continent is not null 
--Group By date
order by 1,2

--To calculate the RollingPepleVaccinated percentage - we cant calculate on a recently created column create temp table first
--USE CTE

With PopvsVac (Continent, Location, Date, Population, New_Vaccinations, RollingPeopleVaccinated)
as
(
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(Cast(vac.new_vaccinations as bigint)) OVER (Partition by dea.location Order by dea.location, cast(
dea.date as datetime)) as RollingPeopleVaccinated
FROM PortfolioProject..CovidDeath dea
Join PortfolioProject..CovidVaccinations vac
	On dea.location = vac.location
	and dea.date = vac.date
Where dea.continent is not null
--Order by 2,3
)
Select *, (RollingPeopleVaccinated/Population)*100
From PopvsVac

--TEMP TABLE

--DROP Table if exists #PercentPopulationVaccinated
Create Table #PercentPopulationVaccinated
(
Continent nvarchar(255),
Location nvarchar(255),
Date datetime,
Population numeric,
New_vaccinations numeric,
RollingPeopleVaccinated numeric
)

Insert into #PercentPopulationVaccinated
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(Cast(vac.new_vaccinations as bigint)) OVER (Partition by dea.location Order by dea.location, cast(
dea.date as datetime)) as RollingPeopleVaccinated
FROM PortfolioProject..CovidDeath dea
Join PortfolioProject..CovidVaccinations vac
	On dea.location = vac.location
	and dea.date = vac.date
--Where dea.continent is not null
--Order by 2,3

SELECT *, (RollingPeopleVaccinated/population)*100
FROM #PercentPopulationVaccinated

-- CREATING VIEW TO STORE DATA FOR LATER VISUALIZATIONS

Create View PercentPopulatedVaccinated as
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(Cast(vac.new_vaccinations as bigint)) OVER (Partition by dea.location Order by dea.location, cast(
dea.date as datetime)) as RollingPeopleVaccinated
FROM PortfolioProject..CovidDeath dea
Join PortfolioProject..CovidVaccinations vac
	On dea.location = vac.location
	and dea.date = vac.date
Where dea.continent is not null
--Order by 2,3

Select *
From PercentPopulatedVaccinated

--Show High Infection Count vs Percent Population Infected (Visualize this data)
Select Location, Population,date, MAX(total_cases) as HighestInfectionCount,  Max((total_cases/population))*100 as PercentPopulationInfected
From PortfolioProject..CovidDeath
--Where location like '%states%'
Group by Location, Population, date
order by PercentPopulationInfected desc

Select Location, Population, MAX(total_cases) as HighestInfectionCount,  Max((total_cases/population))*100 as PercentPopulationInfected
From PortfolioProject..CovidDeath
--Where location like '%states%'
Group by Location, Population
order by PercentPopulationInfected desc

--Total Death Count (Visualize this data)
-- European Union is part of Europe
Select location, SUM(cast(new_deaths as int)) as TotalDeathCount
From PortfolioProject..CovidDeath
--Where location like '%states%'
Where continent is null 
and location not in ('World', 'Low income', 'upper middle income', 'High income', 'Lower middle income', 'European Union', 'International')
Group by location
order by TotalDeathCount desc
