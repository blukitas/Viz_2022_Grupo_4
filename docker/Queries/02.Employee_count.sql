-- * Are businesses growing or shrinking?

-- How many distinct employees in a jobid, distinct by day
  select to_char(cast("timestamp" as "timestamp"), 'YYYY-MM-DD') as ts 
       , j.employerid
       , count(distinct(participantid)) employees_count
	from activitylogs a
  	  inner join jobs j on a.jobid = cast(j.jobid as varchar)
	where 1 = 1 
	  -- and to_char(cast("timestamp" as "timestamp"), 'MM') = '03'
      and j.employerid  = '413'
	group by to_char(cast("timestamp" as "timestamp"), 'YYYY-MM-DD') 
           , j.employerid
    order by to_char(cast("timestamp" as "timestamp"), 'YYYY-MM-DD') asc
