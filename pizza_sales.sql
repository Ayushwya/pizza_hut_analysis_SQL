create database pizza;
use pizza;
select * from pizzas;
select * from pizza_types;
create table orders(order_id int not null,order_date date not null,
order_time time not null,
primary key(order_id));
select * from orders;
create table orders_details(order_details_id int not null,order_id int not null,
pizza_id text not null,quantity int not null,
primary key(order_details_id));
select * from order_details;

alter table orders_details rename to order_details;


-- total revenue generated from pizza sales
use pizza;
select 
      SUM(order_details.quantity * pizzas.price) AS total_sales from      
    order_details JOIN
    pizzas ON pizzas.pizza_id = order_details.pizza_id;
-- OUTPUT= 817860.049999993
    
-- The highest priced pizza
select pizza_types.name, pizzas.price
from pizza_types join pizzas
on pizza_types.pizza_type_id = pizzas.pizza_type_id
order by pizzas.price desc limit 1;
-- output= The Greek Pizza	35.95

-- identify the most common sized pizza ordered 
select * from order_details;

select pizzas.size, count(order_details.order_details_id) as order_count
from pizzas join order_details
on pizzas.pizza_id=order_details.pizza_id
group by pizzas.size order by order_count desc;
-- OUTPUT=
-- L	18526
-- M	15385
-- S	14137
-- XL	544
-- XXL	28

-- 5 most ordered pizza types alonh with quantities
select pizza_types.name,
sum(order_details.quantity) as quantity
from pizza_types join pizzas
on pizza_types.pizza_type_id = pizzas.pizza_type_id
join order_details
on order_details.pizza_id = pizzas.pizza_id
group by pizza_types.name order by quantity desc limit 5;
-- OUTPUT 
-- The Classic Deluxe Pizza	2453
-- The Barbecue Chicken Pizza	2432
-- The Hawaiian Pizza	2422
-- The Pepperoni Pizza	2418
-- The Thai Chicken Pizza	2371




-- join the necessary tables to find the total quantity of  
-- each pizza category ordered.

select pizza_types.category,
sum(order_details.quantity) as quantity
from pizza_types join pizzas
on pizza_types.pizza_type_id = pizzas.pizza_type_id
join order_details
on order_details.pizza_id = pizzas.pizza_id
group by pizza_types.category order by quantity desc;
-- Classic	14888
-- Supreme	11987
-- Veggie	11649
-- Chicken	11050OUTPUT=



-- DEtermine the distribution of orders by hours of the day

select hour(order_time)as hour, count(order_id) as order_count from orders
group by hour(order_time);
-- 11  1231
-- 12	2520
-- 13	2455
-- 14	1472
-- 15	1468
-- 16	1920
-- 17	2336
-- 18	2399
-- 19	2009
-- 20	1642
-- 21	1198
-- 22	663
-- 23	28
-- 10	8
-- 9	1




-- join relevant tables to find the category
-- category-wise ditribution of pizzas.alter

select category , count(name) from pizza_types
group by category;
-- Chicken	6
-- Classic	8
-- Supreme	9
-- Veggie	9

-- group the ordrs by date and calculate the average number 
-- of pizzas ordered per day

select pizza_types.category,
sum(order_details.quantity) as quantity
from pizza_types join pizzas
on pizza_types.pizza_type_id = pizzas.pizza_type_id
join order_details
on order_details.pizza_id = pizzas.pizza_id
group by pizza_types.category order by quantity desc;
-- Classic	14888
-- Supreme	11987
-- Veggie	11649
-- Chicken	11050

 -- determine the distribution of orders by hours of the day
 
 select hour(order_time) as hour, count(order_id) as order_count from orders
 group by hour (order_time);

-- category wise distributio of pizzas

select category, count(name) from pizza_types
group by category;

-- group the orders by date and  calulate the average 
-- number of pizzas ordered per day

select round (avg(quantity),0) av_pizza_ord from
(select orders.order_date,sum(order_details.quantity) as quantity
from orders join order_details
on orders.order_id=order_details_id
group by orders.order_date) as order_quantity;

-- determine the top 3 most ordered pizza types based on revenue

select pizza_types.name ,
sum(order_details.quantity * pizzas.price) as revenue
from pizza.pizza_types join pizzas
on pizzas.pizza_type_id = pizza_types.pizza_type_id
join order_details
on order_details.pizza_id = pizzas.pizza_id
group by pizza_types.name order by revenue desc limit 3;

-- The Thai Chicken Pizza	43434.25
-- The Barbecue Chicken Pizza	42768
-- The California Chicken Pizza	41409.5
