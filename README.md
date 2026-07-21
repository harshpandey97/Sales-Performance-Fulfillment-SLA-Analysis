<div align="center">

# 📱💻 Electronics Retail Sales Performance & Fulfillment SLA Analysis

![SQL Server](https://img.shields.io/badge/SQL_Server-T--SQL-red?style=for-the-badge&logo=microsoftsqlserver)
![Python](https://img.shields.io/badge/Python-Pandas%20|%20Matplotlib%20|%20Seaborn-blue?style=for-the-badge&logo=python)
![Excel](https://img.shields.io/badge/Excel-Dashboard-green?style=for-the-badge&logo=microsoftexcel)
![Orders](https://img.shields.io/badge/Orders-50,000-success?style=for-the-badge)
![Status](https://img.shields.io/badge/Project-Completed-brightgreen?style=for-the-badge)

### SQL • Python • Excel • Business Intelligence • Data Analytics

An end-to-end analysis of **50,000 Electronics Retail Orders** to evaluate revenue performance, customer demand, and fulfillment SLA using **SQL Server**, **Python**, and **Excel**.

</div>

---

# 📌 Project Overview

This project analyzes electronics retail sales data from **March 2023 – March 2025**.

The analysis covers:

- 📈 Sales Performance
- 💰 Revenue Analysis
- 🏷 Brand Performance
- 🌍 Regional Analysis
- 📦 Product Category Analysis
- 🚚 Dispatch Delay
- 📊 SLA Performance
- 💻 Product Specification Analysis

---

# 🚨 Executive Summary

> The average dispatch delay is **30.6 days** across almost every brand and region.

This indicates a **system-wide operational bottleneck** rather than an issue with any specific vendor or geographic region.

<div align="center">

<img src="charts/07_delay_by_brand.png" width="850">

</div>

---

# 📊 KPI Dashboard

| KPI | Value |
|------|-------|
| 💰 Total Revenue | ₹2,827.9 Crore |
| 📦 Orders | 50,000 |
| 🧾 Average Order Value | ₹5.66 Lakh |
| 🚚 Average Dispatch Delay | 30.6 Days |

---

# 📈 Revenue Performance

## Monthly Revenue Trend

<div align="center">

<img src="charts/01_monthly_revenue_trend.png" width="850">

</div>

---

## Revenue by Brand

<div align="center">

<img src="charts/02_revenue_by_brand.png" width="850">

</div>

---

## Revenue by Region

<div align="center">

<img src="charts/03_revenue_by_region.png" width="850">

</div>

---

## Product Split

<div align="center">

<img src="charts/04_product_split.png" width="700">

</div>

---

# 🚚 Fulfillment Analysis

## Dispatch Delay Distribution

<div align="center">

<img src="charts/05_delay_distribution.png" width="850">

</div>

---

## SLA Breakdown

<div align="center">

<img src="charts/06_sla_breakdown.png" width="850">

</div>

---

## SLA Performance

| SLA Bucket | Orders |
|------------|---------|
| 🟢 1–7 Days | 11.5% |
| 🟡 8–14 Days | 11.7% |
| 🟠 15–30 Days | 26.6% |
| 🔴 31–60 Days | 50.2% |

---

# 💻 Product Specification Analysis

<div align="center">

<img src="charts/08_price_by_ram.png" width="750">

</div>

### Key Insight

RAM configuration has minimal impact on selling price.

Average selling price remains approximately **₹1.02–₹1.03 Lakh** across all RAM categories.

---

# 📂 Repository Structure

```text
Sales-Performance-Fulfillment-SLA-Analysis/
│
├── README.md
├── LICENSE
│
├── charts/
│   ├── 01_monthly_revenue_trend.png
│   ├── 02_revenue_by_brand.png
│   ├── 03_revenue_by_region.png
│   ├── 04_product_split.png
│   ├── 05_delay_distribution.png
│   ├── 06_sla_breakdown.png
│   ├── 07_delay_by_brand.png
│   └── 08_price_by_ram.png
│
├── sql/
│   └── analysis_queries.sql
│
├── python/
│   └── eda_analysis.py
│
├── excel/
│   └── Electronics_Sales_Fulfillment_Analysis.xlsx
│
└── dataset/
    └── mobile_sales_data.csv
```

---

# 🛠 Technology Stack

- Microsoft SQL Server
- SQL (T-SQL)
- Python
- Pandas
- Matplotlib
- Seaborn
- Microsoft Excel

---

# 📄 SQL Analysis

The SQL script contains queries for:

- Revenue KPIs
- Monthly Revenue
- Revenue by Brand
- Revenue by Region
- Product Category Analysis
- Average Order Value
- Dispatch Delay
- SLA Bucket Analysis
- Delay by Brand
- Delay by Region
- Product Specification Analysis
- Top Selling Products

---

# ▶️ How to Run

## SQL

Execute

```sql
analysis_queries.sql
```

inside SQL Server.

---

## Python

```bash
pip install pandas matplotlib seaborn
```

Run

```bash
python eda_analysis.py
```

---

## Excel

Open

```
Electronics_Sales_Fulfillment_Analysis.xlsx
```

---

# 🎯 Key Business Insights

- Revenue is evenly distributed across brands.
- West region generated the highest revenue.
- Mobile and Laptop sales are nearly equal.
- More than 50% of orders experienced severe delays.
- Delay pattern is almost identical across brands and regions.
- Operational improvements are needed in logistics and dispatch processes.

---

# 👨‍💻 Author

## Harsh Pandey

**Data Analyst | SQL | Python | Excel | Power BI**

🔗 GitHub: https://github.com/HARSHPANDEY9756

---

<div align="center">

⭐ If you found this project helpful, consider giving it a Star!

</div>
