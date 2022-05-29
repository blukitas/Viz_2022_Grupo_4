-- Cambios por mes de los gastos en distintas categorias

select to_char(cast("timestamp" as "timestamp"), 'YYYY-MM') as ts 
	 , f.category
	 , sum(f.amount)
  from financialjournal f
  where f.category = 'Food'
  group by to_char(cast("timestamp" as "timestamp"), 'YYYY-MM')
	 , f.category


--Related to: Are standards of living improving or declining over time?

-- How does the financial health of the residents change over the period covered by the dataset? How do wages compare to the overall cost of living in Engagement? 

--  * Promedio mensual de montos atribuidos a cada categoria

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


select 
	month, 
	ROUND(avg(wage_amt)::numeric, 2) as avg_wage_amt, 
	ROUND(avg(food_amt)::numeric, 2) as avg_food_amt, 
	ROUND(avg(education_amt)::numeric, 2) as avg_education_amt, 
	ROUND(avg(shelter_amt)::numeric, 2) as avg_shelter_amt
from vo_monthly_wage
group by 1;


--Are there groups that appear to exhibit similar patterns?

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

select 
	month, 
    educationlevel, -- Podemos cambiar el nivel de agrupamiento
	ROUND(avg(wage_amt)::numeric, 2) as avg_wage_amt, 
	ROUND(avg(food_amt)::numeric, 2) as avg_food_amt, 
	ROUND(avg(education_amt)::numeric, 2) as avg_education_amt, 
	ROUND(avg(shelter_amt)::numeric, 2) as avg_shelter_amt
from 
	vo_monthly_wage
group by 1
order by 1,4