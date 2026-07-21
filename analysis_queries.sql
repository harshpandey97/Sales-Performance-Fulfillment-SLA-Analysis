/* ============================================================
   Electronics Retail — Sales Performance & Fulfillment SLA Analysis
   SQL Analysis Queries
   Database: DEPARTMENT_NEW | Table: dbo.mobile_sales_data
   ============================================================ */

USE DEPARTMENT_NEW;

-- 1. Overall KPIs
SELECT 
    COUNT(*) AS Total_Orders,
    SUM(Price * [Quantity Sold]) AS Total_Revenue,
    AVG(CAST(Price AS FLOAT)) AS Avg_Price,
    SUM([Quantity Sold]) AS Total_Units_Sold,
    AVG(CAST(Price AS FLOAT) * [Quantity Sold]) AS Avg_Order_Value
FROM [mobile_sales_data];

-- 2. Revenue by Product Type (Mobile vs Laptop)
SELECT 
    Product,
    COUNT(*) AS Orders,
    SUM([Quantity Sold]) AS Units_Sold,
    SUM(Price * [Quantity Sold]) AS Total_Revenue
FROM [mobile_sales_data]
GROUP BY Product
ORDER BY Total_Revenue DESC;

-- 3. Revenue by Brand (Top 10)
SELECT TOP 10
    Brand,
    SUM(Price * [Quantity Sold]) AS Total_Revenue,
    COUNT(*) AS Orders
FROM [mobile_sales_data]
GROUP BY Brand
ORDER BY Total_Revenue DESC;

-- 4. Revenue by Region
SELECT 
    Region,
    SUM(Price * [Quantity Sold]) AS Total_Revenue,
    COUNT(*) AS Orders
FROM [mobile_sales_data]
GROUP BY Region
ORDER BY Total_Revenue DESC;

-- 5. Monthly Revenue Trend
SELECT 
    YEAR([Inward Date]) AS Yr,
    MONTH([Inward Date]) AS Mo,
    SUM(Price * [Quantity Sold]) AS Revenue
FROM [mobile_sales_data]
GROUP BY YEAR([Inward Date]), MONTH([Inward Date])
ORDER BY Yr, Mo;

-- 6. Dispatch Delay (Fulfillment SLA) — the key differentiator analysis
SELECT 
    AVG(CAST(DATEDIFF(DAY, [Inward Date], [Dispatch Date]) AS FLOAT)) AS Avg_Delay_Days,
    MIN(DATEDIFF(DAY, [Inward Date], [Dispatch Date])) AS Min_Delay,
    MAX(DATEDIFF(DAY, [Inward Date], [Dispatch Date])) AS Max_Delay
FROM [mobile_sales_data];

-- 7. SLA Bucket Breakdown (% of orders in each delay band)
SELECT 
    CASE 
        WHEN DATEDIFF(DAY, [Inward Date], [Dispatch Date]) BETWEEN 1 AND 7 THEN '1-7 days (Good)'
        WHEN DATEDIFF(DAY, [Inward Date], [Dispatch Date]) BETWEEN 8 AND 14 THEN '8-14 days (Acceptable)'
        WHEN DATEDIFF(DAY, [Inward Date], [Dispatch Date]) BETWEEN 15 AND 30 THEN '15-30 days (Delayed)'
        ELSE '31-60 days (Severely Delayed)'
    END AS SLA_Bucket,
    COUNT(*) AS Order_Count,
    CAST(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER() AS DECIMAL(5,2)) AS Pct_of_Orders
FROM [mobile_sales_data]
GROUP BY 
    CASE 
        WHEN DATEDIFF(DAY, [Inward Date], [Dispatch Date]) BETWEEN 1 AND 7 THEN '1-7 days (Good)'
        WHEN DATEDIFF(DAY, [Inward Date], [Dispatch Date]) BETWEEN 8 AND 14 THEN '8-14 days (Acceptable)'
        WHEN DATEDIFF(DAY, [Inward Date], [Dispatch Date]) BETWEEN 15 AND 30 THEN '15-30 days (Delayed)'
        ELSE '31-60 days (Severely Delayed)'
    END;

-- 8. Is dispatch delay brand-specific or systemic? (Avg delay per brand)
SELECT 
    Brand,
    AVG(CAST(DATEDIFF(DAY, [Inward Date], [Dispatch Date]) AS FLOAT)) AS Avg_Delay_Days,
    COUNT(*) AS Orders
FROM [mobile_sales_data]
GROUP BY Brand
ORDER BY Avg_Delay_Days DESC;

-- 9. Is dispatch delay region-specific? (Avg delay per region)
SELECT 
    Region,
    AVG(CAST(DATEDIFF(DAY, [Inward Date], [Dispatch Date]) AS FLOAT)) AS Avg_Delay_Days,
    COUNT(*) AS Orders
FROM [mobile_sales_data]
GROUP BY Region
ORDER BY Avg_Delay_Days DESC;

-- 10. Price premium check — Average price by RAM tier
SELECT 
    RAM,
    AVG(CAST(Price AS FLOAT)) AS Avg_Price,
    COUNT(*) AS Orders
FROM [mobile_sales_data]
GROUP BY RAM
ORDER BY Avg_Price DESC;

-- 11. Top 10 highest-revenue product codes (best sellers)
SELECT TOP 10
    [Product Code],
    Product,
    Brand,
    SUM([Quantity Sold]) AS Total_Units,
    SUM(Price * [Quantity Sold]) AS Total_Revenue
FROM [mobile_sales_data]
GROUP BY [Product Code], Product, Brand
ORDER BY Total_Revenue DESC;

-- 12. Orders with severe delay (31+ days) needing operational attention
SELECT 
    Region,
    Brand,
    COUNT(*) AS Severely_Delayed_Orders
FROM [mobile_sales_data]
WHERE DATEDIFF(DAY, [Inward Date], [Dispatch Date]) > 30
GROUP BY Region, Brand
ORDER BY Severely_Delayed_Orders DESC;
