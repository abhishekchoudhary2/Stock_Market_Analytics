-- Which stocks/companies have the highest trading activity (number of trades, trades per day)?

select 
company_name,
avg(number_of_trades)as avg_number_of_trades,
avg(trades_per_day)as avg_trades_per_day
 from
 stock_data
 where
 company_name is not null
 and number_of_trades is not null
 and trades_per_day is not null
 group by
 company_name
 order by 
 avg_trades_per_day desc,
 avg_number_of_trades desc
 limit 5;

 -- What does delivery percentage reveal about investment vs speculative activity, by settlement type and sector?
 
select 
coalesce(sector, 'Unclassified Sector') as sector,
coalesce(settlement_type,'Standard') as settlement_type,
count(*) as valid_delivery_records,
round(avg(delivery_pct), 2) as avg_delivery_pct,
round(min(delivery_pct), 2) as min_delivery_pct,
round(max(delivery_pct), 2) as max_delivery_pct
from stock_data
where delivery_pct is not null
group by
coalesce(sector, 'Unclassified Sector'),
coalesce(settlement_type, 'Standard')
order by
avg_delivery_pct desc;
