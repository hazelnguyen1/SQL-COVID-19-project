--data is in: --https://www.kaggle.com/josephassaker/covid19-global-dataset 
select * from [COVID Project]..covid

--average new cases in Vietnam
select avg(daily_new_cases) 
from [COVID Project]..covid
where country like '%viet%' 

--highest number of total cases in each country
select country, max(cumulative_total_cases) as max_cases
from [COVID Project]..covid
group by country
order by max_cases desc

--highest number of total deaths in each country
select country, max(cumulative_total_deaths) as max_deaths
from [COVID Project]..covid
group by country
order by max_deaths desc

-- countries with the highest death rate
select country, max(cumulative_total_deaths/nullif(cumulative_total_cases,0)) as death_rate
from [COVID Project]..covid
where cumulative_total_cases is not null
group by country
order by death_rate desc

-- total cases, deaths, and death rate across the world by day
select date, sum(daily_new_cases) as world_cases, sum(daily_new_deaths) as world_deaths, sum(daily_new_deaths)/sum(daily_new_cases) as world_rate
from [COVID Project]..covid
group by date 
order by date

--total cases, total deaths and death rate up to date across the world
select date, sum(cumulative_total_cases),sum(cumulative_total_deaths),sum(cumulative_total_deaths)/sum(cumulative_total_cases)
from [COVID Project]..covid
where date ='2022-01-05'
group by date

