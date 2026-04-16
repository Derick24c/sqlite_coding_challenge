-- Task 1: Top 5 Customers by Total Spend
SELECT 
    c.first_name || ' ' || c.last_name AS customer_full_name,
    SUM(oi.quantity * oi.unit_price) AS total_spend
FROM customers c
JOIN orders o 
    ON c.id = o.customer_id
JOIN order_items oi 
    ON o.id = oi.order_id
GROUP BY c.id, c.first_name, c.last_name
ORDER BY total_spend DESC
LIMIT 5; -- c -> customers, o -> orders, oi -> order_items

-- Task 2: Total Revenue by Product Category
SELECT 
    p.category,
    SUM(oi.quantity * oi.unit_price) AS Revenue -- Revenue per line item
FROM order_items oi
JOIN products p
    on oi.product_id = p.id
JOIN orders o
    ON oi.order_id = o.id
GROUP BY p.category -- Total revenue by category descending
ORDER BY revenue DESC; 


--Task 3: Employees Earning above Department Average

SELECT 
    e.first_name,
    e.last_name,
    d.name AS department_name,
    e.salary AS employee_salary,
    dept_avg.avg_salary AS department_average
FROM employees e

JOIN departments d
    on e.department_id = d.id
JOIN (
    SELECT 
        department_id,
        AVG(salary) AS avg_salary
    FROM employees
    GROUP BY department_id
) dept_avg
    ON e.department_id = dept_avg.department_id
WHERE e.salary > dept_avg.avg_salary
ORDER BY d.name, e.salary DESC;

-- Task 4: Cities with most loyal customers

SELECT city,
    COUNT(*) AS gold_customer_count
FROM customers
WHERE loyalty_level = 'Gold'
GROUP BY city
ORDER BY gold_customer_count DESC, city ASC;

