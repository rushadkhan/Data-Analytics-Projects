select c.Category_Name as category_name, concat(First_Name,' ',Last_Name) as employee_full_name, 
cast(sum(od.Quantity * (od.Unit_Price - (od.Unit_Price * od.Discount))) as decimal(10,2)) as total_sale_amount,
cast(sum((od.Quantity * (od.Unit_Price - (od.Unit_Price * od.Discount))) * 100 / tsa.TotalSaleAmount) as decimal(10,2)) as percent_of_employee_sales,
cast(sum((od.Quantity * (od.Unit_Price - (od.Unit_Price * od.Discount))) * 100/ tsac.TotalSaleAmount) as decimal(10,2)) as percent_of_category_sales
from Order_Details od
inner join orders o
on od.Order_ID = o.Order_ID
inner join Products p
on od.Product_ID = p.Product_ID 
inner join categories c 
on p.Category_ID = c.Category_ID
inner join employees e
on o.Employee_ID = e.Employee_ID
inner join (
	select p.Category_ID, sum(od.Quantity * (od.Unit_Price - (od.Unit_Price * od.Discount))) as TotalSaleAmount 
	from Order_Details od
	inner join Orders o
	on o.Order_ID = od.Order_ID
	inner join Products p
	on p.Product_ID = od.Product_ID
	group by p.Category_ID
)tsa
on p.Category_ID = tsa.Category_ID
inner join(
	select o.Employee_ID, sum(od.Quantity * (od.Unit_Price - (od.Unit_Price * od.Discount))) as TotalSaleAmount
	from Order_Details od
	inner join orders o
	on od.Order_ID = o.Order_ID
	inner join Products p
	on od.Product_ID = p.Product_ID 
	inner join categories c 
	on p.Category_ID = c.Category_ID
	group by o.Employee_ID
) tsac
on o.Employee_ID = tsac.Employee_ID
group by Category_Name, concat(First_Name,' ',Last_Name)
order by c.Category_Name asc, Total_Sale_Amount desc