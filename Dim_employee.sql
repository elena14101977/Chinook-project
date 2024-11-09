
select e.employeeid ,e.lastname ,e.firstname ,e.title ,e.reportsto ,e.departmentid ,
e.birthdate::date,e.hiredate::date,e.address ,e.city ,e.state ,e.country ,e.postalcode ,
e.phone ,e.fax ,e.email ,e.last_update ,d.department_name ,d.budget ,
age(current_date ,e.hiredate) as employment_time, -- number of employment years
{{ domain('e.email') }} as domain , -- extracting domain from email using macro
case when e.employeeid  in (select distinct(reportsto)from {{ source('stg','employee') }} ) then 1 --adding a column that shoes if the employee is manager 
     else 0
        end as is_manager,
'{{run_started_at.strftime("%y-%m-%d %H:%M:%S")}}' as dbt_run_time -- DBT run time
from {{ source('stg','employee') }} e
left join {{ source('stg','department_budget') }} d
on e.departmentid =d.department_id 

