
select pt.playlistid ,
p.name as playlist_name,
pt.trackid ,
pt.last_update,
'{{run_started_at.strftime("%y-%m-%d %H:%M:%S")}}' as dbt_run_time --adding DBT run time column
from {{ source('stg','playlisttrack') }} pt
left join {{source ('stg','playlist') }} p 
on p.playlistid =pt.playlistid 


