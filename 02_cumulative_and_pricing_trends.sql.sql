/* ==============================================================================
   STEP 1: Cumulative Sales & Multi-Period Trend Analysis
   
   Business Objective:
   - Part 1.1: Monitor intra-year monthly velocity with a Year-to-Date (YTD) running 
               total that resets every January.
   - Part 1.2: Track macro multi-year growth, cumulative lifetime sales, and pricing 
               trends using expanding moving averages.
   
   SQL Techniques Used:
   - Common Table Expressions (CTEs): Clean intermediate data aggregation.
   - Date Truncation: DATETRUNC(month, ...), DATETRUNC(year, ...)
   - Window Functions:
       * SUM() OVER (PARTITION BY ... ORDER BY ...) -> YTD Cumulative Sales
       * SUM() OVER (ORDER BY ...)                  -> Lifetime Cumulative Sales
       * AVG() OVER (ORDER BY ...)                  -> Moving/Expanding Average Price
   ============================================================================== */

-- ------------------------------------------------------------------------------
-- 1.1 Monthly Level: YTD Cumulative Sales (Resets Annually)
-- ------------------------------------------------------------------------------
WITH monthly_sale AS 
(SELECT 
DATETRUNC(MONTH,order_date) AS Order_date,
SUM(sales_amount) AS Total_Sales
FROM GOLD.fact_sales
WHERE order_date IS NOT NULL
GROUP BY DATETRUNC(MONTH,order_date)
)

SELECT Order_date,
 Total_Sales,
SUM(Total_Sales) OVER (PARTITION BY DATETRUNC(YEAR, Order_date)ORDER BY Order_date) AS RUNNING_TOTAL
FROM monthly_sale

-- ------------------------------------------------------------------------------
-- 1.2 Yearly Level: Lifetime Cumulative Sales & Moving Average Pricing
-- ------------------------------------------------------------------------------


WITH yearly_sales_summary AS 
(SELECT 
DATETRUNC(YEAR,order_date) AS order_year,
SUM(sales_amount) AS Total_Sales,
AVG(price) AS Avg_Price 
FROM GOLD.fact_sales
WHERE order_date IS NOT NULL
GROUP BY DATETRUNC(YEAR,order_date)
)

SELECT order_year,
 Total_Sales,
SUM(Total_Sales) OVER (ORDER BY order_year) AS RUNNING_TOTAL,
avg_price,
AVG(Avg_Price) OVER (ORDER BY order_year) AS Moving_Averege_Price
FROM yearly_sales_summary

