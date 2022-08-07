select c.Category_Name,'Below $20' as price_range,
cast(sum(od.Unit_Price - od.Unit_Price*od.Discount) as int) as total_amount, count(od.Order_ID) as total_number_orders  
from Order_Details od
inner join Products p
on od.Product_ID = p.Product_ID
inner join Categories c
on c.Category_ID = p.Category_ID
where p.Unit_Price < 20
group by Category_Name
union all
select c.Category_Name,'20$ - 50$' as price_range,
cast(sum(od.Unit_Price - od.Unit_Price*od.Discount) as int) as total_amount, count(od.Order_ID) as total_number_orders 
from Order_Details od
inner join Products p
on od.Product_ID = p.Product_ID
inner join Categories c
on c.Category_ID = p.Category_ID
where p.Unit_Price between 20 and 50
group by Category_Name
union all
select c.Category_Name,'Over 50$' as price_range,
cast(sum(od.Unit_Price - od.Unit_Price*od.Discount) as int) as total_amount, count(od.Order_ID) as total_number_orders  
from Order_Details od
inner join Products p
on od.Product_ID = p.Product_ID
inner join Categories c
on c.Category_ID = p.Category_ID
where p.Unit_Price > 50
group by Category_Name
order by Category_Name, price_range 