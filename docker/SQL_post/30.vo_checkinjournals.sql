-- base query
drop table if exists vo_checkinjournals;

create table vo_checkinjournals as
 	select participantid,
		to_timestamp(replace("timestamp",'T',' '),'YYYY-MM-DD HH24:MI:00Z') as from_timestamp,
		to_timestamp(replace(lead(timestamp) over(partition by participantid order by "timestamp") ,'T',' '),'YYYY-MM-DD HH24:MI:00Z') as to_timestamps,
		DATE_PART('hour', (to_timestamp(replace(lead(timestamp) over(partition by participantid order by "timestamp") ,'T',' '),'YYYY-MM-DD HH24:MI:00Z')) - 
		(to_timestamp(replace("timestamp",'T',' '),'YYYY-MM-DD HH24:MI:00Z'))) as hour_diff,
		venueid ,
		venuetype 
	from checkinjournal c 
	order by 2
