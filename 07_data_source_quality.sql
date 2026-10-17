-- How complete/reliable is each data source (Moneycontrol/Bloomberg/Reuters/NSE Bhavcopy)? 

select
data_source,
count(*) as total_records,
round(count(*) *100.0 / sum(count(*)) over (), 2) as share_percentage,
sum(case when open_interest_lots is not null then 1 else 0 end) as valid_oi_records,
round(
sum(case when open_interest_lots is not null then 1 else 0 end) *100.0 / count(*) , 2
) as completeness_percentage
from stock_data
group by data_source
order by total_records desc;
