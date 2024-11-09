{{config(materialized='incremental') }} --incremental table

 select 
        invoicelineid,
        invoiceid,
        trackid,
        unitprice,
        quantity,
        last_update,
        '{{run_started_at.strftime("%y-%m-%d %H:%M:%S")}}' as dbt_run_time --DBT run time
from {{ source('stg', 'invoiceline') }} 
{% if is_incremental() %}
where last_update > (select max(last_update) from {{this}}) -- update only new uptated rows
{% endif %}
