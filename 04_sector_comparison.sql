-- How do Banking vs IT sectors compare on next day directions?

select 
sector,
count(*) as  total_stocks,
round(sum(case when next_day_direction ='down' then 1 else 0 end) *100.0/count(*),2) as down_pct,
round(sum(case when next_day_direction ='flat' then 1 else 0 end) *100.0/count(*),2) as flat_pct,
round(sum(case when next_day_direction ='up' then 1 else 0 end) *100.0/count(*),2) as up_pct
from stock_data
where sector in('Private Bank','Public Sector Bank','Small Finance Bank','IT Services')
and next_day_direction in('up','down','flat')
group by sector
order by sector;

