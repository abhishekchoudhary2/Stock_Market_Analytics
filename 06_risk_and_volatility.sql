-- Which market cap segments carry the highest circuit-hit risk?

select 
market_cap_segment,
count(*) as total_records,
sum(circuit_hit) as total_circuit_hits,
round(avg(circuit_hit) *100, 2 ) as circuit_hit_percentage
from stock_data
where circuit_hit is not null
and market_cap_segment is not null
and lower(Trim(market_cap_segment)) <> 'Unknown'
group by market_cap_segment
order by circuit_hit_percentage desc;

-- Is trading status (Active/Suspended/Halted) linked to volatility (ATR) or sector?

select
case 
when lower(trim(trading_status)) =
'unknown' 
then 'Unclassified'
else trading_status
end as trading_status,
count(*) as total_records,
count(atr_14) as records_with_atr,
round(avg(atr_14),2) as average_atr,
round(count(atr_14) *100.0 / count(*),2) as atr_availability_pct
from stock_data
where trading_status is not null 
group by 
case
when lower(trim(trading_status)) =
'unknown'
then 'Unclassified'
else trading_status
end
order by average_atr desc;

select
sector,
case
when lower(trim(trading_status)) ='unknown'
then 'unclassified'
else trading_status
end as trading_status,
count(*) as total_records,
round(count(*) * 100.0 /
sum(count(*)) over(partition by sector), 2 ) as status_percentage
from stock_data
where sector is not null
and trading_status is not null
group by sector,case
when lower(trim(trading_status)) = 'unknown'
then 'Unclassified'
else trading_status
end
order by 
sector,
status_percentage desc;

--  How concentrated is open interest across settlement modes (Cash/F&O;/Margin)?

select
replace(settlement_mode,'Unknown','Unclassified') as settlement_mode,
sum(open_interest_lots) as total_oi_lots,
round(
sum(open_interest_lots)*100.0 / sum(sum(open_interest_lots)) over() , 2
) as concentration_percentage
from stock_data
group by replace(settlement_mode,'Unknown','Unclassified')
order by concentration_percentage desc;
