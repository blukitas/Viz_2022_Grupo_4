
drop table if exists vo_monthly_wage;

with monthly_spend as (
	select 
		to_char(cast("timestamp" as date),'yyyy-MM') as month, 
		participantid,
		sum(case when category = 'Wage' then amount else 0 end) as wage_amt,
		sum(case when category = 'Food' then amount else 0 end) as food_amt,
		sum(case when category = 'Education' then amount else 0 end) as education_amt,
		sum(case when category = 'Shelter' then amount else 0 end) as shelter_amt 
	from financialjournal a
	group by to_char(cast(a."timestamp" as date),'yyyy-MM'), 
			 participantid
)
select 
	ms.month, 
	ms.participantid,
	ROUND(wage_amt::numeric, 2) as wage_amt,
	ROUND(food_amt::numeric, 2) as food_amt,
	ROUND(education_amt::numeric, 2) as education_amt,
	ROUND(shelter_amt::numeric, 2) as shelter_amt,
	ROUND(wage_amt::numeric, 2) as earning_amt,
	ROUND((food_amt + education_amt + shelter_amt)::numeric, 2) as spend_amt,
	ROUND((wage_amt - food_amt + education_amt + shelter_amt)::numeric, 2) as balance_amt
  into vo_monthly_wage
from monthly_spend ms;

