use newfile;
select * from mydata;
/*Question 1: Write a SQL query to find the Average order value, total number of orders, first
order date, last order date, first order value, last order value of a customer. */

SELECT AVG(placed_gmv) AS average_order_value,
       COUNT(order_id) AS total_orders,
       MIN(Order_Date) AS first_order_date,
       MAX(Order_Date) AS last_order_date,
       MIN(placed_gmv) AS first_order_value,
       MAX(placed_gmv) AS last_order_value
FROM mydata
GROUP BY order_id;


/* Question 2: From the given data, if we had to list the top 20 products in our Popular
Products category, how would you pick the products and rank them? */

SELECT product_name,
       SUM(placed_gmv) AS total_sales
FROM mydata
GROUP BY product_name
ORDER BY total_sales DESC
LIMIT 20;


/*Question 3: Write a SQL query to find out the top 3 articles for each customer in terms of
placed_gmv.*/

WITH RankedOrders AS (
    SELECT customer_id, sku_id, product_name, placed_gmv,
    RANK() OVER (PARTITION BY customer_id ORDER BY placed_gmv DESC) AS rank_value
    FROM mydata
)
SELECT customer_id, sku_id, product_name, placed_gmv
FROM RankedOrders
WHERE rank_value <= 3;
