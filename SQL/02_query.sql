select ship_country, round(avg(shipped_date - order_date),2) as average_days_between_order_shipping, 
count(*) as total_number_orders 
from orders
where extract(year from order_date) = 1998
group by ship_country
having avg(shipped_date - order_date) > 4 and count(*) > 10