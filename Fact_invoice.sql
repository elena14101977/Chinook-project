{{ config(materialized='incremental') }} --incremental table

 select invoiceid ,customerid ,invoicedate::date as invoicedate ,
            billingaddress ,billingcity ,billingstate ,
            billingcountry ,billingpostalcode ,
            total ,last_update,
            '{{run_started_at.strftime("%y-%m-%d %H:%M:%S")}}' as dbt_run_time --adding DBT run time
from {{ source('stg', 'invoice') }} 
{% if is_incremental() %}
where last_update > (select max(last_update) from {{ this }}) -- update only new uptated rows
{% endif %}
