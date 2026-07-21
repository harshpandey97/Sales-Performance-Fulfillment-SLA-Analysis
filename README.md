# 📱💻 Electronics Retail — Sales Performance & Fulfillment SLA Analysis

End-to-end analysis of a 50,000-order electronics retail dataset (Mobile Phones & Laptops, Mar 2023 – Mar 2025), covering **revenue performance** and **order fulfillment SLA**, built with **SQL + Python (Pandas/Matplotlib/Seaborn)** and delivered as an **Excel workbook**.

The headline finding: dispatch delay averages **~31 days** and stays within a narrow band across *every* brand and region — pointing to a **systemic fulfillment bottleneck**, not a vendor- or region-specific problem.

---

## 📁 Repository Structure

```
├── Electronics_Sales_Fulfillment_Analysis.xlsx   # Final workbook (raw data + 4 analysis sheets)
├── eda_analysis.py                               # Python EDA script (Pandas + Matplotlib/Seaborn)
├── analysis_queries.sql                          # 12 SQL Server queries used for the analysis
└── charts/                                        # Exported chart images (PNG)
    ├── 01_monthly_revenue_trend.png
    ├── 02_revenue_by_brand.png
    ├── 03_revenue_by_region.png
    ├── 04_product_split.png
    ├── 05_delay_distribution.png
    ├── 06_sla_breakdown.png
    ├── 07_delay_by_brand.png
    └── 08_price_by_ram.png
```

---

## 🗂️ File-by-File Description

### `Electronics_Sales_Fulfillment_Analysis.xlsx`
The final deliverable workbook — 5 sheets:

| Sheet | Contents |
|---|---|
| **Raw Data** | All 50,000 order-level records (Product, Brand, Price, Inward/Dispatch Date, Quantity Sold, Customer, Region, RAM/ROM/SSD specs, derived Revenue/Delay_Days/SLA_Bucket columns). |
| **Overview** | Executive KPI summary — total orders, total revenue, avg order value, avg dispatch delay. |
| **Revenue Analysis** | Revenue & order count broken down by Brand, Region, Product Type, and Month. |
| **Fulfillment SLA** | SLA bucket breakdown (% of orders in each delay band) plus avg delay by Brand and by Region. |
| **Spec vs Price** | Avg price by RAM tier — checks whether higher specs command a price premium. |

### `eda_analysis.py`
Python script that loads the raw CSV, derives `Revenue`, `Delay_Days`, `YearMonth`, and `SLA_Bucket` columns, computes the executive KPI summary, and generates the chart set (monthly revenue trend, SLA breakdown, delay-by-brand) using Matplotlib/Seaborn with a consistent navy/orange color palette.

### `analysis_queries.sql`
12 T-SQL queries (SQL Server, `DEPARTMENT_NEW.dbo.mobile_sales_data`) covering: overall KPIs, revenue by product/brand/region/month, dispatch delay stats, SLA bucket breakdown, delay-by-brand and delay-by-region (systemic vs isolated check), price premium by RAM tier, top-selling product codes, and severely delayed orders needing operational attention.

### `charts/`
8 exported PNG visuals used in the workbook/README — see the [Charts section](#-charts) below.

---

## 🔑 Key Findings

**Business performance**
- **Total revenue:** ₹2,827.9 Cr across 50,000 orders (Mar 2023 – Mar 2025)
- **Avg order value:** ₹5.66 Lakh
- **Product mix is near-even:** Laptops ₹1,418.7 Cr (50.3%) vs Mobile Phones ₹1,409.2 Cr (49.7%)
- **Top brand by revenue:** Google (₹151.5 Cr, 2,598 orders); **top region:** West (₹585.7 Cr, 10,288 orders) — though brand and region revenue are otherwise fairly evenly spread
- **Spec vs price:** no meaningful price premium across RAM tiers (4GB to 32GB all average ~₹1.02–1.03 Lakh) — pricing in this dataset isn't spec-driven

**Fulfillment / SLA performance**
- **Avg dispatch delay:** 30.6 days
- **SLA breakdown:** only 11.5% of orders dispatch within a week (Good), 11.7% in 8–14 days (Acceptable), 26.6% in 15–30 days (Delayed), and **50.2% take 31–60 days (Severely Delayed)**
- **Systemic, not isolated:** avg delay by brand ranges only 30.0–31.1 days, and by region only 30.4–30.9 days — every brand and region is delayed by roughly the same amount, ruling out a single vendor or region as the root cause

---

## 📊 Charts

| Chart | Description |
|---|---|
| `01_monthly_revenue_trend.png` | Revenue trend month-over-month, Mar 2023 – Mar 2025 |
| `02_revenue_by_brand.png` | Top 10 brands by total revenue |
| `03_revenue_by_region.png` | Revenue split across the 5 regions |
| `04_product_split.png` | Revenue share: Mobile Phone vs Laptop |
| `05_delay_distribution.png` | Distribution of dispatch delay (days), with mean marked |
| `06_sla_breakdown.png` | % of orders in each SLA bucket |
| `07_delay_by_brand.png` | Avg dispatch delay per brand vs overall average — shows the systemic pattern |
| `08_price_by_ram.png` | Avg price by RAM tier — spec premium check |

---

## 🧰 Tech Stack

- **SQL Server (T-SQL)** — aggregation and KPI queries
- **Python** — Pandas (data cleaning/derivation), Matplotlib + Seaborn (visualization)
- **Excel** — final KPI workbook for stakeholder delivery

## ▶️ How to Reproduce

1. Load `mobile_sales_data.csv` into SQL Server as `DEPARTMENT_NEW.dbo.mobile_sales_data` and run `analysis_queries.sql` for the KPI tables.
2. Run `python eda_analysis.py` (with `mobile_sales_data.csv` in the same folder) to regenerate the charts into `charts/`.
3. Open `Electronics_Sales_Fulfillment_Analysis.xlsx` for the consolidated, stakeholder-ready view.

---

### 👤 Author
**Harsh Pandey** — Data Analyst / BI portfolio project
[GitHub: HARSHPANDEY9756](https://github.com/HARSHPANDEY9756)
