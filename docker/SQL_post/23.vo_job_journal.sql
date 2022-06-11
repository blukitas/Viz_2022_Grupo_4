drop table if exists vo_job_journal;

create table vo_job_journal as
    select 
          a.participantid,
          a.jobid::numeric::integer as jobId, 
          left(min(ts_min),10) as dateFrom, 
          left(max(ts_max),10) as dateTo
      from activitylogs a 
      group by a.participantid,
               a.jobid::numeric::integer;