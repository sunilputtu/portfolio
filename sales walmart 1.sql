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
   -- day_name
   select
       date,
       dayname(date) as day_name
 from sales;
alter table sales add column day_name varchar (10);
update sales
set day_name = dayname(date);

-- month_name
select
    date,
    monthname(date)
    from sales;
    
    alter table sales add column month_name varchar (10);
  
    update sales
    set month_name = monthname(date);
    
    
    


-- ---------------------------------------------------------------------------------------------------------------------------------


-- ---------------------------------------------------------------------------------------------------------------------------------
-- ---------------------------------------------- generic -------------------------------------------------------------------------

-- how many unique cities does the data have ?
select
    distinct city
    from sales;
-- in which city is each branch?
    select 
    distinct branch
    from sales;
    
    select 
        distinct city,
        branch
        from sales;
-- --------------------------------------------------------------------------------------------------------------------------------
-- ---------------------------------------- product -------------------------------------------------------------------------------

-- how many unique product lines does the data have ?
select 
    count(distinct product_line)
    from sales;
    
-- what is the most common payment method ?
select
 payment_method,
count(payment_method) as cnt
 from sales
 group by payment_method
 order by cnt desc;
 
 -- what is the most selling product line ?
 select 
     *
	from sales;
    
select
    product_line,
    count(product_line) as cnt
from sales
group by product_line
order by cnt desc;

-- what is the total revenue by month ?
select
     month_name as month,
     sum(total) as total_revenue
	from sales
    group by month_name
    order by total_revenue desc;
    
 -- what month had a largest cogs ?
 select
      month_name as month,
      sum(cogs) as cogs
    from sales
    group by month_name
    order by cogs desc;
    
-- what product line had the largest revenue?
select
     product_line,
	 sum(total) as total_revenue
from sales
group by product_line
order by total_revenue desc;

-- what is the city with the largest revenue?
select
     branch,
     city,
	 sum(total) as total_revenue
from sales
group by city, branch
order by total_revenue desc;

-- what product line had the largest vat ?
select
     product_line,
     avg(vat) as avg_tax
from sales
group by product_line
order by avg_tax desc;

-- which branch sold more product than average product sold?
select
     branch,
     sum(quantiy) as qty
from sales
group by branch
having sum(quantiy) > (select avg(quantiy) from sales);

-- what is the most comon product line by gender?
select
     gender,
     product_line,
     count(gender) as total_cnt
from sales
group by gender, product_line
order by total_cnt desc;

-- what is the average rating of each produt?
select
  round(avg(rating), 2) as avg_rating,
 product_line
 from sales
 group by product_line
 order by avg_rating desc;
 
 
 -- --------------------------------------------------------------------------------------------------------------------------------
 -- ------------------------------------------- sales ------------------------------------------------------------------------------
 
 -- number of sales made in each time of the day per weekday?
 select 
     time_of_day,
     count(*) as total_sales
     from sales
     where day_name = "sunday"
     group by time_of_day
     order by total_sales desc;
     
-- which of the customer types brings the most revenue?
select
   customer_type,
   sum(total) as total_rev
from sales
group by customer_type
order by total_rev desc;

-- which city has a largest tax percent/ vat (value added tax)?
select
     city,
     avg(vat) as vat
     from sales
     group by city
     order by vat desc;
     
-- which customer type pays the most in vat?
select
     customer_type,
     avg(vat) as vat
     from sales
     group by customer_type
     order by vat desc;
     
-- ---------------------------------------------------------------------------------------------------------------------------------
-- ----------------------------------------- customers -----------------------------------------------------------------------------

-- how many unique customer types does the data have?
select
    distinct customer_type
from sales;

-- how many unique payment methods does the data have?
select
    distinct payment_method
    from sales;
  
-- which customer type buys the most?
select
    customer_type,
    count(*) as customer_cnt
    from sales
    group by customer_type;
    
-- what is the gender of most of the customer?
select
    gender,
    count(*) as gender_cnt
from sales
group by gender
order by gender_cnt desc;

-- what is the gender distribution per branch?
select
    gender,
    count(*) as gender_cnt
from sales
where branch = "a"
group by gender
order by gender_cnt desc;

-- which time of the day do cutomers give most ratings?
select
    time_of_day,
    avg(rating) as avg_rating
from sales
group by time_of_day
order by avg_rating desc;

-- which time of the  day do customers give most rating per branch?
select
    time_of_day,
    avg(rating) as avg_rating
from sales
where branch = "c"
group by time_of_day
order by avg_rating desc;

-- which of the week has best avg rating?
select
     day_name,
     avg(rating) as avg_rating
     from sales
     group by day_name
     order by avg_rating desc;
 
 -- which day of the week has the best average rating per branch?
 select 
      day_name,
      avg(rating) as avg_rating
      from sales
      where branch = "a"
      group by day_name
      order by avg_rating desc;
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 ;

