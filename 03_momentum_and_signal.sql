-- Which stocks show the strongest momentum right now(price above SMA-20,rsi in the 50-70 zone)?

WITH latest_stocks as (
select 
stock_data.company_name,
max(stock_data.last_trade_date) as latest_date
from stock_data
where stock_data.last_trade_date is not null
group by stock_data.company_name
)
select
stock_data.company_name,
stock_data.last_trade_date,
stock_data.close_price,
stock_data.sma_20,
stock_data.rsi_14,
round(
((stock_data.close_price - stock_data.sma_20) / stock_data.sma_20) *100,
2
) as momentum_pct
from stock_data 
join latest_stocks 
on stock_data.company_name = latest_stocks.company_name
and stock_data.last_trade_date=
latest_stocks.latest_date
where stock_data.close_price > 
stock_data.sma_20
and stock_data.rsi_14 between 50 and 70
and stock_data.sma_20>0
order by momentum_pct desc;

-- Which stocks are trading closest to their 52-week high or low?

select 
company_name,
close_price,
week52_high,
pct_from_52w_high
from
stock_data
where 
last_trade_date = (select max(last_trade_date) from stock_data)
and pct_from_52w_high is not null
and close_price is not null
and week52_high is not null
order by 
pct_from_52w_high desc
limit 5;

select 
company_name,
close_price,
week52_low,
pct_from_52w_low
from
stock_data
where 
last_trade_date = (select max(last_trade_date) from stock_data)
and pct_from_52w_low is not null
and close_price is not null
and week52_low is not null
order by 
pct_from_52w_low asc
limit 5;

-- Does a higher analyst rating actually predict an "Up" next-day direction?

SELECT 
    CASE 
        WHEN analyst_rating >= 0 AND analyst_rating < 1 THEN '0-1 (very low)'
        WHEN analyst_rating >= 1 AND analyst_rating < 2 THEN '1-2 (low)'
        WHEN analyst_rating >= 2 AND analyst_rating < 3 THEN '2-3 (moderate)'
        WHEN analyst_rating >= 3 AND analyst_rating < 4 THEN '3-4 (high)'
        WHEN analyst_rating >= 4 AND analyst_rating <= 5 THEN '4-5 (very high)'
        ELSE 'Other'
    END AS rating_tier,
    COUNT(*) AS total_stocks,
    SUM(CASE WHEN next_day_direction = 'Up' THEN 1 ELSE 0 END) AS up_stocks,
    ROUND(
        SUM(CASE WHEN next_day_direction = 'Up' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 
        2
    ) AS up_probability_pct
FROM stock_data
WHERE analyst_rating IS NOT NULL 
  AND next_day_direction IS NOT NULL
GROUP BY 
    CASE 
        WHEN analyst_rating >= 0 AND analyst_rating < 1 THEN '0-1 (very low)'
        WHEN analyst_rating >= 1 AND analyst_rating < 2 THEN '1-2 (low)'
        WHEN analyst_rating >= 2 AND analyst_rating < 3 THEN '2-3 (moderate)'
        WHEN analyst_rating >= 3 AND analyst_rating < 4 THEN '3-4 (high)'
        WHEN analyst_rating >= 4 AND analyst_rating <= 5 THEN '4-5 (very high)'
        ELSE 'Other'
    END
ORDER BY rating_tier;