
drop table if exists vo_monthly_wage;

select 
	to_char(cast(timestamp as date),'yyyy-MM') as month, 
	participantid,
	ROUND(sum(case when category = 'Wage' then amount else 0 end)::numeric, 2) as wage_amt,
	ROUND(sum(case when category = 'Food' then amount else 0 end)::numeric, 2) as food_amt,
	ROUND(sum(case when category = 'Education' then amount else 0 end)::numeric, 2) as education_amt,
	ROUND(sum(case when category = 'Shelter' then amount else 0 end)::numeric, 2) as shelter_amt 
  into vo_monthly_wage
from financialjournal a 
group by 1,2;

