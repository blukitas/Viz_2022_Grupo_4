alter table activitylogs add column ts_spend varchar null;

update activitylogs 
set ts_spend = ts_max::timestamp - ts_min::timestamp;
