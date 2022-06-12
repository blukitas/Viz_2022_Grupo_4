
drop table if exists vo_date;

create table vo_date as
with dates as (
  select 
  		left(ts_min,10) as dt,
  		left(ts_min,10)::date as dt_date
    from activitylogs a 
    group by left(ts_min,10)
)
select dt,
	   dt_date,
	   EXTRACT(year FROM dt_date) dt_year,
	   EXTRACT(month FROM dt_date) dt_month,
	   EXTRACT(QUARTER FROM dt_date) dt_quater,
	   EXTRACT(WEEK FROM dt_date) dt_week_of_year,
	   EXTRACT(day FROM dt_date) dt_day,
	   EXTRACT(DOW FROM dt_date) dt_day_of_week,
	   EXTRACT(DOY FROM dt_date) dt_day_of_year,
	   EXTRACT(EPOCH FROM dt_date) dt_epoch
  from dates;