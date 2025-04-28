#1. Database Setup
# Database Creation: The project starts by creating a database named p1_retail_db
create database p1_retails_db;


# Table Creation: A table named retail_sales is created to store the sales data. The table structure includes columns for transaction ID, sale date, sale time, customer ID, gender, age, product category, quantity sold, price per unit, cost of goods sold (COGS), and total sale amount.
CREATE TABLE retail_sales
(
    transactions_id INT PRIMARY KEY,
    sale_date DATE,	
    sale_time TIME,
    customer_id INT,	
    gender VARCHAR(10),
    age INT,
    category VARCHAR(35),
    quantity INT,
    price_per_unit FLOAT,	
    cogs FLOAT,
    total_sale FLOAT
);

#2. Data Exploration & Cleaning
# Record Count: Determine the total number of records in the dataset.
SELECT 
    COUNT(*)
FROM
    retail_sales;
    
    
# Customer Count: Find out how many unique customers are in the dataset.
SELECT 
    COUNT(DISTINCT customer_id)
FROM
    retail_sales;
    
    
# Category Count: Identify all unique product categories in the dataset.
SELECT 
    category
FROM
    retail_sales
GROUP BY category;

SELECT DISTINCT category FROM retail_sales;

#Null Value Check: Check for any null values in the dataset and delete records with missing data.
SELECT * FROM retail_sales
WHERE 
    sale_date IS NULL OR sale_time IS NULL OR customer_id IS NULL OR 
    gender IS NULL OR age IS NULL OR category IS NULL OR 
    quantity IS NULL OR price_per_unit IS NULL OR cogs IS NULL;

DELETE FROM retail_sales 
WHERE
    sale_date IS NULL OR sale_time IS NULL
    OR customer_id IS NULL
    OR gender IS NULL
    OR age IS NULL
    OR category IS NULL
    OR quantity IS NULL
    OR price_per_unit IS NULL
    OR cogs IS NULL;

 
# 3.Data Analysis & Findings

# 1- Write a SQL query to retrieve all columns for sales made on '2022-11-05:
select*from retail_sales;
select total_sale
from retail_sales
where sale_date='2022-11-05';

# 2-Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022:

select*from retail_sales;
SELECT *
FROM retail_sales
WHERE 
    category = 'Clothing'
    AND 
    DATE_FORMAT(sale_date, '%Y-%m') = '2022-11'
    AND
    quantity >= 4;
    
#3 Write a SQL query to calculate the total sales (total_sale) for each category.:
select sum(total_sale) as sales, category
from retail_sales
group by category;    
    
# 4. Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.:
select *from retail_sales;
select avg(age)
from retail_sales
where category='beauty';


#5. Write a SQL query to find all transactions where the total_sale is greater than 1000
select transactions_id, total_sale
from retail_sales;

#6. Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.:
select count(transactions_id) as transactions, gender, category
from retail_sales
group by 2,3
order by 1 desc;
    SELECT 
    category,
    gender,
    COUNT(*) as total_trans
FROM retail_sales
GROUP 
    BY 
    category,
    gender
ORDER BY 1;


# 7. Write a SQL query to calculate the average sale for each month. Find out best selling month in each year:
select*from retail_sales;
WITH monthly_avg_sales AS (
    SELECT 
        EXTRACT(YEAR FROM sale_date) AS year,
        EXTRACT(MONTH FROM sale_date) AS month,
        AVG(total_sale) AS avg_sale
    FROM retail_sales
    GROUP BY year, month
)
SELECT 
    year,
    month,
    avg_sale
FROM (
    SELECT 
        year,
        month,
        avg_sale,
        RANK() OVER (PARTITION BY year ORDER BY avg_sale DESC) AS rnk
    FROM monthly_avg_sales
) AS ranked_sales
WHERE rnk = 1;

#8 **Write a SQL query to find the top 5 customers based on the highest total sales **:
select*from retail_sales;
select customer_id, sum(total_sale) as sales
from retail_sales
group by customer_id
order by sales desc
limit 5;

#9. Write a SQL query to find the number of unique customers who purchased items from each category.:
select*from retail_sales;
SELECT 
    category,    
    COUNT(DISTINCT customer_id) as cnt_unique_cs
FROM retail_sales
GROUP BY category;

#10 Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17):
WITH hourly_sale
AS
(
SELECT *,
    CASE
        WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'Morning'
        WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
        ELSE 'Evening'
    END as shift
FROM retail_sales
)
SELECT 
    shift,
    COUNT(*) as total_orders    
FROM hourly_sale
GROUP BY shift







