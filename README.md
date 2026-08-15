# Retail Sales Analytics & Customer Segmentation

An end-to-end retail business intelligence project executing customer behavioral segmentation, catalog distribution analysis, and multi-period revenue tracking using Microsoft SQL Server (T-SQL) and Microsoft Excel.

---

## 🎯 Key Business Objectives & Exact Metrics
* **Customer Age Demographic Segmentation:** Dynamically calculates exact customer age using `DATEDIFF` and `DATEADD` conditional logic, grouping customers into four cohorts:
  * `Teenagers (<20)`
  * `Young Adults (20-35)`
  * `Middle-Aged (36-50)`
  * `50+`
* **Customer Behavioral & Value Segmentation:** Analyzes customer tenure (months between first and last order) and monetary spending thresholds:
  * `VIP Customer`: Lifespan >= 12 months and Total Spending > $5,000
  * `Regular Customer`: Lifespan >= 12 months and Total Spending <= $5,000
  * `New Customer`: Lifespan < 12 months
* **Product Cost Distribution:** Segments the entire SKU catalog by unit cost ranges:
  * `Below 100` | `100-500` | `500-1000` | `Above 1000`
* **Year-over-Year (YoY) & Historical Benchmarking:** Evaluates product revenue against historical multi-year averages (`Above Avg`, `Below Avg`, `Avg`) and prior-year sales using `LAG()` window functions (`Increase`, `Decrease`, `No Change`).
* **Cumulative Velocity & Moving Pricing:** Measures Year-to-Date (YTD) running sales totals and tracks moving average selling prices across years.
* **Macro vs. Micro Time-Series Trends:** Compares annual high-level growth with monthly seasonal sales, customer volumes, and unit quantities.

---

## 🛠️ Technical Stack & Advanced SQL Techniques
* **Database Management:** Microsoft SQL Server (T-SQL)
* **Query Architecture:** Single & Chained Common Table Expressions (`WITH customer_demographics`, `customer_lifetime_metrics`)
* **Window Functions:** `AVG() OVER()`, `SUM() OVER()`, `LAG() OVER()` with explicit `PARTITION BY` and `ORDER BY`
* **Date Manipulation:** `DATEDIFF()`, `DATEADD()`, `DATETRUNC()`, `YEAR()`, `GETDATE()`
* **Business Intelligence:** Microsoft Excel connected via Power Query for automated data refreshes and dashboard KPI reporting.

---

## 📈 Key Insights & Analytical Takeaways
*(To be populated following dashboard completion and final metric evaluation)*

* **Demographic Breakdown:** Evaluating revenue share and customer acquisition across age cohorts (`Teenagers`, `Young Adults`, `Middle-Aged`, `50+`).
* **Customer Value Distribution:** Profiling customer concentration across `VIP`, `Regular`, and `New` behavioral tiers.
* **Product Catalog Concentration:** Analyzing SKU distribution and revenue contribution across cost ranges.
* **Temporal & Growth Trends:** Identifying seasonal sales peaks and tracking YoY product revenue variance.
