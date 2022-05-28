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

drop table if exists participants.jobs;

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
 	  --, b.maxoccupancy -- Parece tener muchos nulos
 	  , b.units
      into participants.jobs
   from unique_participant_job u
     left join participants p on p.participantid = u.participantid
     left join jobs j on cast(j.jobid as varchar) = u.jobid
       left join employers e on e.employerid = j.employerid 
         left join buildings b on b.buildingid  = e.buildingid ;
         
        