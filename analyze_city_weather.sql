-- Show schema for relevant tables
select *
from information_schema.columns
where table_name in ('city_data', 'city_list', 'global_data')
order by table_name, column_name;

-- Query global weather data
select *
from global_data
order by year;

-- Check whether Munich/Germany is in the city list
select * 
from city_list
where city = 'Munich';

-- Query city data for Munich/Germany
select *
from city_data
where city = 'Munich' and country = 'Germany'
order by year;

-- Count number of countries that have a city with given name
select s.city, count(s.country)
from (
  select distinct city, country
  from city_data) s
group by s.city
order by 2 desc;

-- Query global and city data in one query, as proposed by Udacity reviewer
select 
  cd.year, cd.city, cd.country, 
  cd.avg_temp as local_temp,
  gd.avg_temp as global_temp
from city_data cd
join global_data gd 
  on cd.year = gd.year
  and cd.avg_temp is not null
where cd.city = 'Munich' 
  and cd.country = 'Germany'
order by cd.year;
