


   select c.customerid,
    initcap(lower(c.firstname)) as firstname, --capital first letter and all others lowercase
    initcap(lower(c.lastname)) as lastname, ----capital first letter and all others lowercase
    c.company,c.address ,c.city,c.state,c.country,c.postalcode ,c.phone ,c.fax,c.email,
    {{ domain('c.email') }}  as domain, -- using macro fanction to extract the domain
    c.supportrepid ,c.last_update,
    '{{run_started_at.strftime("%y-%m-%d %H:%M:%S")}}' as dbt_run_time --DBT run time
    from {{ source('stg','customer') }} c
   
