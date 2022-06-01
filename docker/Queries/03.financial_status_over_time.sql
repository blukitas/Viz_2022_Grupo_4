-- Financial status over time, relation with availablebalance and dailyfoodbudget

with universo as (
	select to_char(cast("timestamp" as "timestamp"), 'YYYY-MM-DD') as ts 
	 , a.participantid
	 , a.financialstatus
	 , case when availablebalance = 'NA' then 0 else cast(availablebalance as decimal(12,6)) end as availablebalance 
	 , case when dailyfoodbudget = 'NA' then 0 else cast(dailyfoodbudget as decimal(12,6)) end as dailyfoodbudget 
	 from activitylogs a
)
select ts 
	 , financialstatus 
	 , count(distinct(participantid))
	 , min(availablebalance) as min_availablebalance
	 , avg(availablebalance) as avg_availablebalance
	 , max(availablebalance) as max_availablebalance
	 , min(dailyfoodbudget) as min_dailyfoodbudget
	 , avg(dailyfoodbudget) as avg_dailyfoodbudget
	 , max(dailyfoodbudget) as max_dailyfoodbudget
from universo
group by ts 
	 , financialstatus ;
	 
/*
 * Current modes:
 * Transport
 * AtHome
 * AtRecreation
 * AtRestaurant
 * AtWork
 */
with participant_current_mode as (	 
	select to_char(cast("timestamp" as "timestamp"), 'YYYY-MM-DD') as ts 
	 	 , a.currentmode
		 , participantid
		 , count(1) as mode_count
	 from activitylogs a 
	 group by to_char(cast("timestamp" as "timestamp"), 'YYYY-MM-DD')
	 	 	, a.currentmode
	 		, participantid 
)
select ts, p.currentmode, avg(p.mode_count) 
from participant_current_mode p
where p.currentmode = 'AtWork'
group by ts, p.currentmode