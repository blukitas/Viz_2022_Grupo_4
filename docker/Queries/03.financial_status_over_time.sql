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
	 , min(availablebalance)
	 , avg(availablebalance)
	 , max(availablebalance)
	 , min(dailyfoodbudget)
	 , avg(dailyfoodbudget)
	 , max(dailyfoodbudget)
from universo
group by ts 
	 , financialstatus 