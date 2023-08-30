--data is in: --https://www.kaggle.com/josephassaker/covid19-global-dataset 

--data cleaning and transformation
I got rid of countries that have lots of null values 
I created another column for income groups for later analysis of these groups
I transformed empty strings into NULL which got rid of many problems with aggregate functions
--The reason I used per million instead of total was because I wanted to compare fairly among countries that have different populations, 
which wouldn't have happened if I used total cases or total deaths

--highest number of deaths in each country
select location, max(total_deaths_per_million) as max_deaths from covid19 
group by location
order by max_deaths desc

--highest number of total cases in each country
select location, max(total_cases_per_million) as max_cases from covid19 
group by location
order by max_cases desc

--Thanks to these, we now know what countries need more vaccines and care for covid patients


--timeframe in a certain country when an outbreak happened 
select location, date, new_cases_per_million from covid19 
where location = 'Wallis and Futuna' and new_cases_per_million >= 228872
--Thanks to this, we can understand the times that a specific country was in danger and research accordingly about how it affected the economy, 
how the govtmt counteracted and how effective that was

--Death rate in a country with time
select location, date, total_deaths_per_million/total_cases_per_million as death_rate from covid19
where location = 'United States'
--This data tells us how well a country was treating COVID patients in different time periods, and helps us compare different countries
regarding care for covid patients

--Death rate in different income groups
select location, date, total_deaths_per_million/total_cases_per_million as death_rate from covid19
where Income = 'Low income'
--We can see how hard Covid is hitting low income group, seeing there is a point when 10% of covid patients in that group died from covid

--Vaccination rate: how many people per hundred people are vaccinated and fully vaccinated?
select location, max(people_vaccinated_per_hundred) as vax_number from covid19
group by location
order by vax_number

select location, max(people_fully_vaccinated_per_hundred) as fully_vax_number from covid19
group by location
order by fully_vax_number
--We can compare how well in each country vaccination is administered

--Median age of population's effect on number of cases
select location, avg(median_age), max(total_cases_per_million) as max_cases from covid19 
group by location
order by max_cases desc
--I found that countries with higher median age tend to have higher number of cases.

--GDP's effect on number of cases
select location, avg(gdp_per_capita), max(total_cases_per_million) as max_cases from covid19 
group by location
order by max_cases desc
--However, countries with higher GDP tend to have higher number of cases. This could be because these countries are better at recording data
