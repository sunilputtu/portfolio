create database if not exists salesdatawalmrt;

create table if not exists sales(
 invoice_id varchar (30) not null primary key,
 branch varchar (5) not null,
 city varchar (30) not null,
 customer_type varchar (30) not null,
 gender varchar (10) not null,
 product_line varchar (100) not null,
 unit_price decimal (10, 2) not null,
 quantiy int not null,
 vat float (6, 4) not null,
 total decimal (12, 4) not null,
 date datetime not null,
 time time not null,
 payment_method varchar (15) not null,
 cogs decimal (10, 2) not null,
 gross_margin_pct float (11, 9),
 gross_income decimal (12, 4) not null,
 rating float (2, 1)
);



-- ---------------------------------------------------------------------------------------------------------------------------------
-- ---------------------------------------------- feature engineering --------------------------------------------------------------

-- time_of_day 

select
	time,
    (case
        when cast(time as time) between "00:00:00" and "12:00:00" then "morning"
	   when cast(time as time) between "00:01:00" and "16:00:00" then "afternoon"
    else "evening"
    end
    ) as time_of_day
   from sales;
   
   alter table sales add column time_of_day varchar (20);
   update sales
   set time_of_day = (case
        when cast(time as time) between "00:00:00" and "12:00:00" then "morning"
	   when cast(time as time) between "00:01:00" and "16:00:00" then "afternoon"
    else "evening"
    end
   );



-- ---------------------------------------------------------------------------------------------------------------------------------