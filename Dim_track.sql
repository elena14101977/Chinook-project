
select t.trackid ,
t.name as track_name,
t.composer ,
t.milliseconds/1000 as seconds, --replacing miliseconds to seconds
lpad(floor( t.milliseconds/1000/60)::text,2,'0')||':'||lpad (( t.milliseconds/1000%60)::text,2,'0') as minute, --song length in MI:SS
t.bytes,
t.unitprice ,
a.albumid ,
a.title as album_title,
at.artistid ,
at.name as artist_name,
m.mediatypeid ,
m.name as mediatype_name,
g.genreid ,
g.name as genre_name,
g.last_update,
'{{run_started_at.strftime("%y-%m-%d %H:%M:%S")}}' as dbt_run_time --adding DBT run time
from {{ source('stg','track') }} t
left join {{ source('stg','album') }} a on t.albumid =a.albumid 
left join {{ source ('stg','artist') }} at on a.artistid =at.artistid 
left join {{ source ('stg','mediatype') }} m on t.mediatypeid =m.mediatypeid 
left join {{ source('stg','genre') }} g on t.genreid =g.genreid 
