
drop table if exists vo_monthly_wage_cohorts;

select 
	to_char(cast(timestamp as date),'yyyy-MM') as month, 
	f.participantid,
	p.householdsize,
	p.age,
	p.educationlevel,
	p.interestgroup,
	ROUND(sum(case when category = 'Wage' then amount else 0 end)::numeric, 2) as wage_amt,
	ROUND(sum(case when category = 'Food' then amount else 0 end)::numeric, 2) as food_amt,
	ROUND(sum(case when category = 'Education' then amount else 0 end)::numeric, 2) as education_amt,
	ROUND(sum(case when category = 'Shelter' then amount else 0 end)::numeric, 2) as shelter_amt 
  into vo_monthly_wage_cohorts
from 
	financialjournal f 
	left join participants p on f.participantid =p.participantid  
group by 1,2,3,4,5,6;