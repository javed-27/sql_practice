--1. How many pizzas were ordered?  
SELECT COUNT(*) AS pizza_order_count
FROM customer_orders;

--2. How many unique customer orders were made?

SELECT  COUNT(DISTINCT (order_id)) AS order_count
FROM customer_orders;

--3. How many successful orders were delivered by each runner?

SELECT  runner_id, COUNT(order_id) AS successful_orders
FROM runner_orders
WHERE distance != 'null'
GROUP BY runner_id;

--4. How many of each type of pizza was delivered?

select pizza_names.pizza_id,pizza_name,count(*) as total_orders 
from customer_orders
join pizza_names
on pizza_names.pizza_id = customer_orders.pizza_id
join runner_orders
on customer_orders.order_id = runner_orders.order_id
where duration != 'null'
group by pizza_names.pizza_id,pizza_name

--5. How many Vegetarian and Meatlovers were ordered by each customer?

SELECT customer_id,customer_orders.pizza_id,pizza_name,count(*) as total_orders
FROM customer_orders
INNER JOIN pizza_names
ON pizza_names.pizza_id = customer_orders.pizza_id
GROUP BY customer_orders.pizza_id ,customer_id,pizza_name
ORDER BY customer_id;

--6. What was the maximum number of pizzas delivered in a 
--single order?

SELECT order_id,COUNT(*) as orders FROM customer_orders
GROUP BY order_id
ORDER BY orders DESC;

--7. For each customer, how many delivered pizzas had at 
--least 1 change and how many had no changes?

SELECT 
    customer_id,
    sum(CASE 
        WHEN (exclusions IS NOT NULL AND exclusions not in ('','null'))
          OR (extras IS NOT NULL AND extras  not in ('','null'))
        THEN 1 
        ELSE 0 
    END) AS changes,
   sum (CASE 
        WHEN (exclusions IS NULL OR exclusions = '' OR exclusions = 'null')
         AND (extras IS NULL OR extras = '' OR extras = 'null')
        THEN 1 
        ELSE 0 
    END) AS no_changes
FROM customer_orders
group by customer_id
ORDER BY customer_id;