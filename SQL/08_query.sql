select c.Category_Name, p.Product_Name,p.Unit_Price ,round(s.AverageUnitPrice :: decimal,2) as average_unit_price, 
round(s.Median :: decimal, 2) as median_unit_price,
case when p.Unit_Price > s.AverageUnitPrice then 'Over Average' 
when p.Unit_Price = s.AverageUnitPrice then
'Equal Average' else 'Below Average' end as average_unit_price_position,
case when p.Unit_Price > s.Median then 'Over Median' when p.Unit_Price = s.Median then
'Equal Median' else 'Below Median' end as median_unit_price_position
from Products p
inner join Categories c
on p.Category_ID = c.Category_ID
inner join (
select c.Category_ID, avg(p.Unit_Price) as AverageUnitPrice, PERCENTILE_DISC(0.5)
   WITHIN GROUP ( ORDER BY p.Unit_Price) as Median
from Products p
inner join Categories c
on p.Category_ID = c.Category_ID
inner join Suppliers s 
on p.Supplier_ID = s.Supplier_ID
where p.Discontinued= 0
group by c.Category_ID) s
on c.Category_ID = s.Category_ID
order by Category_Name,Product_Name