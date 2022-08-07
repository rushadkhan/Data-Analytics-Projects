select concat(concat(date_part('year',order_date),'-',lpad(date_part('month',order_date)::text,2, '0')),'-','01') 
as year_month,
count(*) as total_number_orders, round(sum(freight)::decimal,0) as total_freight
from orders
where extract(year from order_date) between 1997 and 1998 
group by concat(concat(date_part('year',order_date),'-',lpad(date_part('month',order_date)::text,2, '0')),'-','01')
having count(*) > 35 
order by total_freight desc