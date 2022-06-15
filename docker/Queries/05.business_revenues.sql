-- base query
create temporary table vo_checkinjournals as
select participantid,
to_timestamp(replace("timestamp",'T',' '),'YYYY-MM-DD HH24:MI:00Z') as from_timestamp,
to_timestamp(replace(lead(timestamp) over(partition by participantid order by "timestamp") ,'T',' '),'YYYY-MM-DD HH24:MI:00Z') as to_timestamps,
DATE_PART('hour', (to_timestamp(replace(lead(timestamp) over(partition by participantid order by "timestamp") ,'T',' '),'YYYY-MM-DD HH24:MI:00Z')) - 
(to_timestamp(replace("timestamp",'T',' '),'YYYY-MM-DD HH24:MI:00Z'))) as hour_diff,
venueid ,
venuetype 
from checkinjournal c 
order by 2

--pubs revenue
select
cast(from_timestamp as date) as dt,
venuetype,
venueid,
sum(hour_diff * hourlycost) as revenue
from vo_checkinjournals c 
inner join pubs p on c.venueid = p.pubid 
group by 1,2,3
order by 1;

--restaurant revenue 
select
cast(from_timestamp as date) as dt,
venuetype,
venueid,
sum(foodcost) --sum(hour_diff * hourlycost) as revenue
from vo_checkinjournals c 
inner join restaurants p on c.venueid = p.restaurantid  
group by 1,2,3
order by 1;

--apartments revenue
drop table vo_apartment_journal;
create temporary table vo_apartment_journal as
select 
		a.apartmentid::numeric::integer as apartmentid, 
		to_date(to_char(cast(ts_min as date),'yyyy-MM-01'), 'yyyy-MM-dd') month_dt,
		left(min(ts_min),10) as dateFrom, 
		left(max(ts_max),10) as dateTo
from activitylogs a 
group by 1,2;

create table business_revenues as
select
cast(from_timestamp as date) as dt,
venuetype,
venueid,
sum(hour_diff * hourlycost) as revenue
from vo_checkinjournals c 
inner join pubs p on c.venueid = p.pubid 
group by 1,2,3

union all

select 
month_dt, 'apartment', c.apartmentId, sum(rentalCost) 
from vo_apartment_journal c
inner join apartments a 
	on c.apartmentid = a.apartmentid 
group by 1,2,3

union all 

select
cast(from_timestamp as date) as dt,
venuetype,
venueid,
sum(foodcost) --sum(hour_diff * hourlycost) as revenue
from vo_checkinjournals c 
inner join restaurants p on c.venueid = p.restaurantid  
group by 1,2,3;

select * from business_revenues;