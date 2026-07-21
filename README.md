<div align="center">

# 📱💻 Electronics Retail — Sales Performance & Fulfillment SLA Analysis

![SQL](https://img.shields.io/badge/SQL-Server-CC2927?style=flat-square&logo=microsoftsqlserver&logoColor=white)
![Python](https://img.shields.io/badge/Python-Pandas%20%7C%20Matplotlib%20%7C%20Seaborn-3776AB?style=flat-square&logo=python&logoColor=white)
![Excel](https://img.shields.io/badge/Excel-Workbook-217346?style=flat-square&logo=microsoftexcel&logoColor=white)
![Orders](https://img.shields.io/badge/Orders-50%2C000-informational?style=flat-square)
![Period](https://img.shields.io/badge/Period-Mar%202023%20--%20Mar%202025-informational?style=flat-square)

End-to-end analysis of a 50,000-order electronics retail dataset (Mobile Phones & Laptops), covering **revenue performance** and **order fulfillment SLA**, built with **SQL + Python** and delivered as an **Excel workbook**.

</div>

---

## 🚨 The Headline Finding

> Dispatch delay averages **~31 days** and stays within a **narrow ~1-day band across every single brand and region** — pointing to a **systemic fulfillment bottleneck**, not a vendor- or region-specific problem.

<div align="center">
<img src="charts/07_delay_by_brand.png" width="720" alt="Avg Dispatch Delay by Brand">
</div>

---

## ⚡ KPI Snapshot

<div align="center">

| 💰 Total Revenue | 📦 Total Orders | 🧾 Avg Order Value | 🚚 Avg Dispatch Delay |
|:---:|:---:|:---:|:---:|
| **₹2,827.9 Cr** | **50,000** | **₹5.66 Lakh** | **30.6 days** |

</div>

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

## 💰 Revenue Performance

<table>
<tr>
<td width="50%">

**Monthly Trend**
<img src="charts/01_monthly_revenue_trend.png" width="100%">

</td>
<td width="50%">

**Top 10 Brands**
<img src="charts/02_revenue_by_brand.png" width="100%">

</td>
</tr>
<tr>
<td width="50%">

**Revenue by Region**
<img src="charts/03_revenue_by_region.png" width="100%">

</td>
<td width="50%">

**Mobile vs Laptop Split**
<img src="charts/04_product_split.png" width="100%">

</td>
</tr>
</table>

**Reading the numbers:**
- Product mix is near-even: Laptops ₹1,418.7 Cr (50.3%) vs Mobile Phones ₹1,409.2 Cr (49.7%)
- Top brand: **Google** (₹151.5 Cr, 2,598 orders) — but revenue is otherwise fairly evenly spread across brands
- Top region: **West** (₹585.7 Cr, 10,288 orders) — all 5 regions land within a tight ₹265 Cr band

---

## 🚚 Fulfillment / SLA Performance

<table>
<tr>
<td width="50%">

**Delay Distribution**
<img src="charts/05_delay_distribution.png" width="100%">

</td>
<td width="50%">

**SLA Breakdown**
<img src="charts/06_sla_breakdown.png" width="100%">

</td>
</tr>
</table>

<details>
<summary><b>🔍 Click to see the systemic-vs-isolated diagnosis (delay by brand, shown above in Headline Finding)</b></summary>
<br>

- Avg delay by **brand** ranges only **30.0–31.1 days** (Sony lowest, Samsung highest)
- Avg delay by **region** ranges only **30.4–30.9 days** (Central lowest, South highest)
- Both spreads are under 1.2 days — nowhere near enough variation to blame a single vendor, product line, or region
- **Conclusion:** this is a process/operations-level bottleneck (e.g. warehouse, logistics partner, or inward-to-dispatch handoff), not a brand or region issue

</details>

**SLA breakdown:**

| Bucket | % of Orders |
|---|---|
| 🟢 1–7 days (Good) | 11.5% |
| 🟡 8–14 days (Acceptable) | 11.7% |
| 🟠 15–30 days (Delayed) | 26.6% |
| 🔴 31–60 days (Severely Delayed) | **50.2%** |

---

## 🔧 Spec vs Price Check

<div align="center">
<img src="charts/08_price_by_ram.png" width="600" alt="Average Price by RAM Tier">
</div>

No meaningful price premium across RAM tiers — 4GB to 32GB all average **~₹1.02–1.03 Lakh**. Pricing in this dataset isn't spec-driven.

---

## 🗂️ File-by-File Description

<details>
<summary><b>📘 Electronics_Sales_Fulfillment_Analysis.xlsx</b> — click to expand</summary>
<br>

| Sheet | Contents |
|---|---|
| **Raw Data** | All 50,000 order-level records (Product, Brand, Price, Inward/Dispatch Date, Quantity Sold, Customer, Region, RAM/ROM/SSD specs, derived Revenue/Delay_Days/SLA_Bucket columns) |
| **Overview** | Executive KPI summary — total orders, total revenue, avg order value, avg dispatch delay |
| **Revenue Analysis** | Revenue & order count by Brand, Region, Product Type, and Month |
| **Fulfillment SLA** | SLA bucket breakdown plus avg delay by Brand and by Region |
| **Spec vs Price** | Avg price by RAM tier — checks for a spec-driven price premium |

</details>

<details>
<summary><b>🐍 eda_analysis.py</b> — click to expand</summary>
<br>

Loads the raw CSV, derives `Revenue`, `Delay_Days`, `YearMonth`, and `SLA_Bucket` columns, computes the executive KPI summary, and generates the chart set using Matplotlib/Seaborn with a consistent navy/orange palette.

</details>

<details>
<summary><b>🗄️ analysis_queries.sql</b> — click to expand</summary>
<br>

12 T-SQL queries (`DEPARTMENT_NEW.dbo.mobile_sales_data`) covering: overall KPIs, revenue by product/brand/region/month, dispatch delay stats, SLA bucket breakdown, delay-by-brand and delay-by-region (systemic check), price premium by RAM tier, top-selling product codes, and severely delayed orders needing attention.

</details>

---

## 🧰 Tech Stack

`SQL Server (T-SQL)` · `Python (Pandas, Matplotlib, Seaborn)` · `Excel`

## ▶️ How to Reproduce

1. Load `mobile_sales_data.csv` into SQL Server as `DEPARTMENT_NEW.dbo.mobile_sales_data` and run `analysis_queries.sql` for the KPI tables.
2. Run `python eda_analysis.py` (with `mobile_sales_data.csv` in the same folder) to regenerate the charts into `charts/`.
3. Open `Electronics_Sales_Fulfillment_Analysis.xlsx` for the consolidated, stakeholder-ready view.

---

<div align="center">

### 👤 Author
**Harsh Pandey** — Data Analyst / BI Portfolio Project
[GitHub: HARSHPANDEY9756](https://github.com/HARSHPANDEY9756)

</div>
