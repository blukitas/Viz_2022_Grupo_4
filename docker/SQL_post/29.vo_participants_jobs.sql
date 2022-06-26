
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
         
        