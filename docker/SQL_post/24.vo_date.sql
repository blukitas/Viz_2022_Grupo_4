
drop table if exists vo_date;

create table vo_date as
    select left(ts_min,10) as dt
      from activitylogs a 
      group by left(ts_min,10);
