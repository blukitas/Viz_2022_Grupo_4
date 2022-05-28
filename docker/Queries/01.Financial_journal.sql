-- Cambios por mes de los gastos en distintas categorias

select to_char(cast("timestamp" as "timestamp"), 'YYYY-MM') as ts 
	 , f.category
	 , sum(f.amount)
  from financialjournal f
  where f.category = 'Food'
  group by to_char(cast("timestamp" as "timestamp"), 'YYYY-MM')
	 , f.category


--Related to: Are standards of living improving or declining over time?
