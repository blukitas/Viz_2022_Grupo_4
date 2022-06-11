drop table if exists vo_job_participant_log;

create table vo_job_participant_log as
	select *
	  from vo_date vd
	    left join vo_job_journal vjj on vd.dt between vjj.dateFrom and vjj.dateTo
	 order by dt desc;