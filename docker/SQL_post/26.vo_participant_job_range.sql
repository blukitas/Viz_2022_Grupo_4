
drop table if exists vo_participant_job_range;

with hire_fire as (
	select 
	    dt
	  , jobid
	  , participantid
	  , (case when dt = dateFrom then 1 else 0 end) as is_a_hire
	  , (case when dt = dateTo then 1 else 0 end) as is_a_fire
	  , (case when dt >= dateFrom 
	            or dt <= dateTo 
	          then 1 
	          else 0 
         end) as is_working
	from vo_job_participant_log vjj
)
select 
	dt, 
	e.employerid, 
	sum(hf.is_a_hire) as cant_contrataciones,
	sum(hf.is_a_fire) as cant_despidos,
	sum(hf.is_working) as cant_trabajadores
	into vo_participant_job_range
 from  hire_fire hf
  inner join  jobs j     on j.jobid::numeric::integer = hf.jobid
  inner join employers e on e.employerid = j.employerid  
 group by hf.dt, 
		  e.employerid
order by hf.dt, 
		  e.employerid;