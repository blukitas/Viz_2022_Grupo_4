-- Unique jobs for each participant
-- create schema if not exists participants;

-- How many unique jobs has each participant?
with unique_participant_jobs as (
	select a.participantid
		 , a.jobid
		 , count(1) as cant_lecturas
	from activitylogs a 
	group by a.participantid, a.jobid
)
select u.participantid
     , count(distinct(u.jobid)) jobId
from unique_participant_jobs u
group by u.participantid
-- To filter more than 1
-- having count(distinct(u.jobid)) > 1
;

-- Multiple jobs implies changes? or can be simoultaneous?
select jobid
     , min("timestamp")
     , max("timestamp")
     , min(weeklyextrabudget)
     , max(weeklyextrabudget)  
  from activitylogs a 
  where participantid = 4
  --and jobid = '1';
  group by jobid;


-------------------------------------------------------
-- CREATE TABLE participans.jobs
-------------------------------------------------------

drop table if exists vo_participants_jobs;

with unique_participant_job as (
	select participantid
		 , jobid 
	  from activityLogs
	  group by participantid
		 	 , jobid
 )
 select u.participantid
 	  , u.jobid
 	  , j.hourlyrate
 	  , j.starttime
 	  , j.endtime
 	  , j.daystowork
 	  , j.educationrequirement
 	  , j.employerid
 	  --, e."location" emp_location -- No me da util la geolocalizacion
 	  , e.buildingid 
 	  , b.buildingtype
	  , case 
		  when pu.pubid is not null then 'Pub'
		  when r.restaurantid is not null then 'Restaurant'
		  when s.schoolid is not null then 'School'
		  else 'Other' end as business_type
 	  --, b.maxoccupancy -- Parece tener muchos nulos
 	  , b.units
      into vo_participants_jobs
   from unique_participant_job u
     left join participants p on p.participantid = u.participantid
     left join jobs j on cast(j.jobid as varchar) = u.jobid
       left join employers e on e.employerid = j.employerid 
         left join buildings b on b.buildingid  = e.buildingid
		   left join pubs pu on pu.buildingid = b.buildingid 
		   left join restaurants r on r.buildingid = b.buildingid 
		   left join schools s on s.buildingid = b.buildingid ;
         
        