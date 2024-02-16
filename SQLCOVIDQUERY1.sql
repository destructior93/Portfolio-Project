select * 
from [Portfolio Project].dbo.[covid-deaths]
where continent is not null
order by 3,4

select * 
from [Portfolio Project].dbo.[covid-vaccinations]
order by 3,4

-- Select Data that we are going to be using

Select Location, date, total_cases, new_cases, total_deaths, population
from [Portfolio Project].dbo.[covid-deaths]
where location like '%Andorra%'
order by 1,2

-- Looking at total cases vs total deaths --(Total_deaths/total_cases)*100 likelyhood of dying if you contract covid in your country

Select Location, date, total_cases, total_deaths, (cast(total_deaths as float)/cast(total_cases as float))*100 as DeathPercentage
from [Portfolio Project].dbo.[covid-deaths]
where location like '%Andorra%'
order by 1,2

-- Looking at the total cases vs the population

Select Location, date, total_cases, total_deaths, population, (cast(total_cases as float)/cast(population as float))*100 as InfectionPercentage, (cast(total_deaths as float)/cast(population as float))*100 as DeathsPopulationPercentage
from [Portfolio Project].dbo.[covid-deaths]
order by 1,2

-- Looking at countries with Highest infection rate compared to population

Select Location, Population, MAX(cast(total_cases as float)) as HighestInfectionCount, Max(cast(total_deaths as float)) as Total_deaths, Max(cast(total_cases as float)/cast(population as float))*100 as InfectionPercentage,
Max(cast(total_deaths as float)/cast(population as float))*100 as DeathsPopulationPercentage
from [Portfolio Project].dbo.[covid-deaths]
group by Location, Population
order by DeathsPopulationPercentage desc

-- query for world zone groups and incomes

select location, max(cast(total_deaths as int)) as TotalDeathCount
from [Portfolio Project].dbo.[covid-deaths]
where continent is null
group by location
order by TotalDeathCount desc

-- showing continents with highest death count per population

select continent, max(cast(total_deaths as int)) as TotalDeathCount
From [Portfolio Project].dbo.[covid-deaths]
where continent is not null
group by continent
order by TotalDeathCount desc

-- Global numbers

set arithabort off
set ansi_warnings off
Select sum(new_cases) as total_cases, sum(new_Deaths) as total_deaths, sum(new_deaths) / sum(new_cases) * 100 as DeathPercentage
from [Portfolio Project].dbo.[covid-deaths]
where continent is not null
order by 1,2

-- looking at total population vs vaccinations

select cvdea.continent, cvdea.location, cvdea.date, cvdea.population, cvvac.new_vaccinations,
	sum(cast(cvvac.new_vaccinations as int)) OVER (Partition by cvdea.Location Order By cvdea.Location, cvdea.date) as RollingPeopleVaccinated
from [Portfolio Project].dbo.[covid-deaths] cvdea
join [Portfolio Project].dbo.[covid-vaccinations] cvvac
	on cvdea.Location = cvvac.location
	and cvdea.date = cvvac.date
	where cvdea.continent is not null
	order by 2,3

-- use cte

with PopvsVac (Continent, Location, Date, Population, New_vaccinations, RollingPeopleVaccinated) as
(
select cvdea.continent, cvdea.location, cvdea.date, cvdea.population, cvvac.new_vaccinations,
	sum(cast(cvvac.new_vaccinations as int)) OVER (Partition by cvdea.Location Order By cvdea.Location, cvdea.date) as RollingPeopleVaccinated
from [Portfolio Project].dbo.[covid-deaths] cvdea
join [Portfolio Project].dbo.[covid-vaccinations] cvvac
	on cvdea.Location = cvvac.location
	and cvdea.date = cvvac.date
	where cvdea.continent is not null
	--order by 2,3
)
select *, (RollingPeopleVaccinated / Population) * 100
from PopvsVac

-- temp table

drop table if exists #PercentPopulationVaccinated
create table #PercentPopulationVaccinated
(
Continent nvarchar(255),
Location nvarchar(255),
date datetime,
Population numeric,
New_Vaccinations numeric,
RollingPeopleVaccinated numeric
)

insert into #PercentPopulationVaccinated
select cvdea.continent, cvdea.location, cvdea.date, cvdea.population, cvvac.new_vaccinations,
	sum(cast(cvvac.new_vaccinations as int)) OVER (Partition by cvdea.Location Order By cvdea.Location, cvdea.date) as RollingPeopleVaccinated
from [Portfolio Project].dbo.[covid-deaths] cvdea
join [Portfolio Project].dbo.[covid-vaccinations] cvvac
	on cvdea.Location = cvvac.location
	and cvdea.date = cvvac.date
	where cvdea.continent is not null
	order by 2,3

select *, (RollingPeopleVaccinated / Population) * 100 as PopulationVaccinatedPercentage
from #PercentPopulationVaccinated


-- creating view to store data for later visualizations

Create View PercentPopulationVaccinated as
select cvdea.continent, cvdea.location, cvdea.date, cvdea.population, cvvac.new_vaccinations,
	sum(cast(cvvac.new_vaccinations as int)) OVER (Partition by cvdea.Location Order By cvdea.Location, cvdea.date) as RollingPeopleVaccinated
from [Portfolio Project].dbo.[covid-deaths] cvdea
join [Portfolio Project].dbo.[covid-vaccinations] cvvac
	on cvdea.Location = cvvac.location
	and cvdea.date = cvvac.date
	where cvdea.continent is not null
	--order by 2,3


select *
from PercentPopulationVaccinated