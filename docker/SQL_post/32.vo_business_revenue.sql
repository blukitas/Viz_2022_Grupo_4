drop table if exists vo_business_revenues;

create table vo_business_revenues as
  select
		cast(from_timestamp as date) as dt,
		venuetype,
		venueid,
		sum(hour_diff * hourlycost) as revenue
    from vo_checkinjournals c 
      inner join pubs p on c.venueid = p.pubid 
    group by 1,2,3

  union all

  select 
		month_dt, 
		'apartment', 
		c.apartmentId, 
		sum(rentalCost) 
    from vo_apartment_journal c
	  inner join apartments a on c.apartmentid = a.apartmentid 
	group by 1,2,3

  union all 

  select
		cast(from_timestamp as date) as dt,
		venuetype,
		venueid,
		sum(foodcost) --sum(hour_diff * hourlycost) as revenue
	from vo_checkinjournals c 
	  inner join restaurants p on c.venueid = p.restaurantid  
	group by 1,2,3;
