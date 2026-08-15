/* ==============================================================================
   STEP 1: Category Part-to-Whole Contribution Analysis
   
   Business Objective:
   - Calculate total sales per category alongside overall company sales to determine 
     each category's percentage contribution to total revenue.
   
   SQL Techniques Used:
   - CTE (`SALES_CATEGORY`): Aggregates sales by product category while using an 
     unbounded window function `SUM(SUM(...)) OVER ()` to compute the overall grand total.
   - Type Casting & Rounding: Uses `CAST(... AS float)` to prevent integer truncation, 
     paired with `ROUND(..., 2)` for precision.
   - String Formatting: Uses `CONCAT()` to append the `%` symbol for presentation.
   ============================================================================== */

WITH SALES_CATEGORY AS
(SELECT 
CATEGORY,
SUM(f.sales_amount) AS Total_sales_Cat,
SUM(SUM(f.sales_amount)) OVER () AS Total_sales
FROM GOLD.fact_sales F
LEFT JOIN GOLD.dim_products P
ON F.product_key = P.product_key
GROUP BY CATEGORY)

SELECT category,
Total_sales_Cat,
Total_sales,
CONCAT(ROUND((CAST(Total_sales_Cat AS float)/Total_sales)*100,2),'%') Percentage_total
FROM SALES_CATEGORY
ORDER BY Total_sales_Cat DESC


/* ==============================================================================
   STEP 2: Category Unit Volume Contribution & Part-to-Whole Analysis
   
   Business Objective:
   - Quantify total units sold per product category alongside total company unit volume 
     to determine volume drivers vs. revenue drivers.
   
   SQL Techniques Used:
   - CTE (`QUANTITY_CATEGORY`): Aggregates unit quantity by category and computes 
     the overall business grand total using `SUM(SUM(...)) OVER ()`.
   - Relational JOIN: LEFT JOIN between Fact (`gold.fact_sales`) and Dimension (`gold.dim_products`).
   - Precision & String Formatting: Uses `CAST(... AS float)` with `ROUND()` and `CONCAT()` 
     to format percentage contribution.
   ============================================================================== */


WITH QUANTITY_CATEGORY AS (
    SELECT 
        p.category,
        SUM(f.quantity) AS Total_quantity_Cat,
        SUM(SUM(f.quantity)) OVER () AS Total_quantity
    FROM gold.fact_sales f
    LEFT JOIN gold.dim_products p
        ON f.product_key = p.product_key
    WHERE f.order_date IS NOT NULL
    GROUP BY p.category
)
SELECT 
    category,
    Total_quantity_Cat,
    Total_quantity,
    CONCAT(ROUND((CAST(Total_quantity_Cat AS float) / Total_quantity) * 100, 2), '%') AS Percentage_total
FROM QUANTITY_CATEGORY
ORDER BY Total_quantity_Cat DESC;