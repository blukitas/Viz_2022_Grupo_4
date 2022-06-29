drop table if exists vo_apartment_journal;
create table vo_apartment_journal as
select 
		a.apartmentid::numeric::integer as apartmentid, 
		to_date(to_char(cast(ts_min as date),'yyyy-MM-01'), 'yyyy-MM-dd') month_dt,
		left(min(ts_min),10) as dateFrom, 
		left(max(ts_max),10) as dateTo
  from activitylogs a 
  group by 1,2;
