select distinct p.Product_name, cast(p.Unit_Price as decimal(10,2)) as current_price, cast(od.Unit_Price as decimal(10,2)) as previous_unit_price, cast((p.Unit_Price - 
od.Unit_Price) / od.Unit_Price * 100 as int) as percentage_increase
from Order_Details od
inner join Orders o
on o.Order_ID = od.Order_ID
inner join Products p 
on od.Product_ID = p.Product_ID
inner join (
	select p.Product_ID, min(o.Order_date) as OrderDate from products p
	inner join order_details od
	on p.Product_ID = od.Product_ID
	inner join orders o
	on od.Order_ID = o.Order_ID
	group by p.product_ID
	having count(od.Product_ID) > 10
)a 
on p.Product_ID = a.Product_ID
and o.Order_Date = a.OrderDate
where cast((p.Unit_Price - od.Unit_Price) / od.Unit_Price * 100 as int) not between 20 and 30
	 and cast((p.Unit_Price - od.Unit_Price) / od.Unit_Price * 100 as int) > 0
order by cast((p.Unit_Price - od.Unit_Price) / od.Unit_Price * 100 as int)