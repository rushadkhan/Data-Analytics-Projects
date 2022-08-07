select concat(e.first_name,' ',e.last_name) as employee_full_name, e.title as employee_title, 
date_part('year',e.hire_date) - date_part('year',e.birth_date) as employee_age,
concat(m.first_name,' ',m.last_name) as manager_full_Name,
m.title as manager_title
from employees e
left join employees m
on e.reports_to = m.employee_id
order by employee_age, employee_full_name