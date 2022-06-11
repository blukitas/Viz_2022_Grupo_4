
-- See people, in a job, in a day (See if is a hire, a fire, o si es only a usual worker)
select 
	    vjj.*
	  , e.employerid 
	  , vjj.participantid
	  , (case when dt = dateFrom then 1 else 0 end) as is_a_hire
	  , (case when dt = dateTo then 1 else 0 end) as is_a_fire
	  , (case when dt <> dateFrom 
	            or dt <> dateTo 
	          then 1 
	          else 0 
         end) as is_working
	from vo_job_participant_log vjj
	  left join  jobs j     on j.jobid::numeric::integer = vjj.jobid
	  left join employers e on e.employerid = j.employerid  
	where 1 = 1
	  --and dt = '2022-04-03'
	  --and e.employerid = 1281
      and participantid = 40
    order by dt, participantid

with working_days as (
    -- See working days for a person in a job
	select to_char(cast("ts_min" as "timestamp"), 'YYYY-MM-DD') ts, participantid , jobid, count(1) cant_registros
	  from activitylogs a 
	  where a.participantid = 40 
	    --and to_char(cast("ts_min" as "timestamp"), 'YYYY-MM-DD') = '2022-03-07'
	    --and jobid = '707' 
	  group by to_char(cast("ts_min" as "timestamp"), 'YYYY-MM-DD'), participantid , jobid
	  order by to_char(cast("ts_min" as "timestamp"), 'YYYY-MM-DD') 
	)
-- See not working days
select dt 
  from vo_date d
   left join working_days w on w.ts = d.dt
  where w.ts is null
  