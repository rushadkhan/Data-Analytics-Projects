select c.Category_Name, case when s.country = 'Denmark' or s.country = 'Finland' or s.country = 'France'
or s.country = 'Germany' or s.country = 'Italy' or s.country = 'Netherlands' or s.country = 'Norway' 
or s.country = 'Spain' or s.country = 'Sweden' or s.country = 'UK' then 'Europe' 
when s.country = 'USA' or s.country = 'Canada' or s.country = 'Brazil' then 'America'
else 'Asia-Pacific' end as supplier_region, sum(p.Unit_In_Stock) as units_in_stock, 
sum(p.Unit_On_Order) as units_on_order,
sum(Reorder_Level) as reorder_level
from Products p
inner join Categories c
on p.Category_ID = c.Category_ID
inner join Suppliers s 
on p.Supplier_ID = s.Supplier_ID
group by c.Category_Name, supplier_region
order by Category_Name,supplier_region, reorder_level