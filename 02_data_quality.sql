select count(*) as total_rows from stock_data;

select 
count(*) as total_records,
sum(case when delivery_pct is null then 1 else 0 end) as missing_delivery_pct,
sum(case when close_price is null then 1 else 0 end) as missing_close_price
from stock_data;

select
(sum(case when delivery_pct is not null then 1 else 0 end) * 100.0) / count(*) as delivery_completeness_pct
from stock_data;

select company_name,last_trade_date,count(*) as duplicate_count
from stock_data
group by company_name,last_trade_date
having count(*) > 1;

select count(*) as invalid_records
from stock_data
where close_price < 0 or number_of_trades < 0;
