create schema portfolio_project2;
use portfolio_project2;
create table orders (order_id int primary key,date date,time time);

-- HOW MANY CUSTOMERS PER DAY --
select date, count(*) from orders as no_of_customers 
group by 1 
order by 2 desc;
 
 -- ARE THERE ANY PEAK HOURS --
 select hour(time) , count(*) from orders as peak_hours 
 group by 1 
 order by 2 desc;
 
 -- HOW MANY PIZZAS ARE THERE IN AN ORDER --
 select order_id, sum(quantity) as number_of_pizzas from order_details 
 group by 1 
 order by 2;
 
 -- DO WE HAVE BEST SELLING PIZZA_TYPES -- 
  select pizza_types.name, 
  sum(order_details.quantity) as sold_quantity
 from pizza_types inner join 
 pizza on pizza_types.pizza_type_id = pizza.pizza_type_id
 join 
 order_details on order_details.pizza_id = pizza.pizza_id 
 group by 1 
 order by 2 desc;

-- MONEY MADE THIS YEAR IN THE YEAR 2015 --
select sum(price) from pizza;

-- ARE THERE ANY SEASONALITY IN SALES. SALES DIFFERENTIALS PER QUARTER --
    select quarter (o.date) as quarter, ROUND(SUM(p.price * od.quantity), 2) As Revenue
FROM orders o
        JOIN
    order_details od on o.order_id = od.order_id
        join
    pizza p on od.pizza_id = p.pizza_id
group by 1;

-- SALES DIFFERENTIAL PER MONTH --
 select
    month(o.date) as month_num,
    ROUND(SUM(p.price * od.quantity), 2) as Revenue
from orders o
        join 
        order_details od ON o.order_id = od.order_id
        join
    pizza p on od.pizza_id = p.pizza_id
group by 1
order by 1;