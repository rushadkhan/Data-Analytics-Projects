select CONCAT(emp.first_name,' ',emp.last_name) as employee_full_name,
emp.title as employee_title,
cast(sum(orddetails.unit_price*orddetails.quantity) as decimal(10,2)) as total_sale_amount_excluding_discount,  
count(orddetails.order_id) as total_number_unique_orders,
sum(orddetails.product_id) as total_number_orders,
cast(avg(orddetails.unit_price*orddetails.product_id) as decimal(10,2)) as average_product_amount,
cast(avg(orddetails.unit_price*orddetails.quantity) as decimal(10,2)) as average_order_amount,
cast(sum(quantity*unit_price*discount) as decimal(10,2)) as total_discount_amount,
cast(sum(quantity*unit_price)-sum(quantity*unit_price*discount) as decimal(10,2)) as total_sale_amount_including_discount,
(100 - cast(((sum(unit_price)-sum(unit_price*discount))/sum(unit_price)) as decimal(10,2)) * 100 ) as total_discount_percentage
from order_details orddetails,orders ord,employees as emp 
where ord.employee_id=emp.employee_id and ord.order_id=orddetails.order_id
group by 
emp.employee_id
order by cast(sum(quantity*unit_price)-sum(quantity*unit_price*discount) as decimal(10,2)) DESC