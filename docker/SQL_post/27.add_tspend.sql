alter table activitylogs add column ts_spend varchar null;

update activitylogs 
set ts_spend = ts_max::timestamp - ts_min::timestamp;


alter table activitylogs add column ts_spend_minutes int null;

update activitylogs 
set ts_spend_minutes = EXTRACT(hour from "ts_spend"::time) * 60 + EXTRACT(minute from "ts_spend"::time) + 5;
