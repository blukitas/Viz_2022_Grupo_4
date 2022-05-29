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

create temporary table vo_monthly_wage as
select 
	to_char(cast(timestamp as date),'yyyy-MM') as month, 
	participantid,
	sum(case when category = 'Wage' then amount else 0 end) as wage_amt,
	sum(case when category = 'Food' then amount else 0 end) as food_amt,
	sum(case when category = 'Education' then amount else 0 end) as education_amt,
	sum(case when category = 'Shelter' then amount else 0 end) as shelter_amt 
from financialjournal a 
group by 1,2;


select 
	month, 
	avg(wage_amt) as avg_wage_amt, 
	avg(food_amt) as avg_food_amt, 
	avg(education_amt) as avg_education_amt, 
	avg(shelter_amt) as avg_shelter_amt
from vo_monthly_wage
group by 1;


--Are there groups that appear to exhibit similar patterns?

drop table if exists vo_monthly_wage_cohorts;
create temporary table vo_monthly_wage_cohorts as
select 
	to_char(cast(timestamp as date),'yyyy-MM') as month, 
	f.participantid,
	p.householdsize,
	p.age,
	p.educationlevel,
	p.interestgroup,
	sum(case when category = 'Wage' then amount else 0 end) as wage_amt,
	sum(case when category = 'Food' then amount else 0 end) as food_amt,
	sum(case when category = 'Education' then amount else 0 end) as education_amt,
	sum(case when category = 'Shelter' then amount else 0 end) as shelter_amt 
from 
	financialjournal f 
	left join participants p on f.participantid =p.participantid  
group by 1,2,3,4,5,6;

select 
	month, 
	educationlevel, -- Podemos cambiar el nivel de agrupamiento
	avg(wage_amt) as avg_wage_amt, 
	avg(food_amt) as avg_food_amt, 
	avg(education_amt) as avg_education_amt, 
	avg(shelter_amt) as avg_shelter_amt
from 
	vo_monthly_wage
group by 1,2
order by 1,3