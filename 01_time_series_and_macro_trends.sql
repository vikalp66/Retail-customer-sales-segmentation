/* ==============================================================================
   STEP 1: High-Level Sales & Growth Trends (Macro vs. Micro Time Analysis)
   
   Business Objective:
   - Understand long-term macro performance (Yearly) and identify granular seasonal
     trends/patterns (Monthly) across revenue, customer acquisition, and volume.
   
   SQL Techniques Used:
   - Date Truncation & Extraction: YEAR(order_date), DATETRUNC(month, order_date)
   - Core Aggregations: SUM(sales_amount), COUNT(DISTINCT customer_key), SUM(quantity)
   - Data Cleansing: WHERE order_date IS NOT NULL (removes invalid/null transaction records)
   - Grouping & Temporal Ordering: GROUP BY, ORDER BY
   ============================================================================== */

-- ------------------------------------------------------------------------------
-- 1.1 Yearly Overview (Macro Trends)
-- ------------------------------------------------------------------------------
SELECT
YEAR(order_date) AS Order_Year,
SUM(sales_amount)AS Total_sales,
COUNT(DISTINCT customer_key) as Total_customers,
SUM(Quantity) as Total_quantity
FROM gold.fact_sales
WHERE order_date IS NOT NULL
GROUP BY YEAR(order_date)
ORDER BY YEAR(order_date)

-- ------------------------------------------------------------------------------
-- 1.2 Monthly Trend Analysis (Seasonality & Monthly Velocity)
-- -----------------------------------------------------------------------------
SELECT
DATETRUNC(MONTH,order_date) AS Order_Year,
SUM(sales_amount)AS Total_sales,
COUNT(DISTINCT customer_key) as Total_customers,
SUM(Quantity) as Total_quantity
FROM gold.fact_sales
WHERE order_date IS NOT NULL
GROUP BY DATETRUNC(MONTH,order_date)
ORDER BY DATETRUNC(MONTH,order_date)
