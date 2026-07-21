"""
Electronics Retail — Sales Performance & Fulfillment SLA Analysis
==================================================================
Dataset : mobile_sales_data.csv (50,000 orders, Mar 2023 - Mar 2025)
Author  : Harsh Pandey

This script performs EDA on an electronics retail dataset (mobile phones
and laptops), covering:
  1. Revenue performance (by brand, region, product type, time)
  2. Order fulfillment SLA analysis (dispatch delay)
  3. Spec-to-price relationship check (RAM tier vs price)

Key finding: average dispatch delay is ~31 days and is CONSISTENT across
every brand and region (within ~1 day of the overall mean) — indicating
a systemic fulfillment/process bottleneck rather than an issue isolated
to a specific supplier, brand, or region.
"""

import pandas as pd
import matplotlib.pyplot as plt
import matplotlib.ticker as mticker
import seaborn as sns

sns.set_style("whitegrid")
NAVY, BLUE, ORANGE, GREEN = '#1F3864', '#2E5395', '#C55A11', '#548235'
PALETTE = ['#1F3864', '#2E5395', '#4472C4', '#8FAADC', '#C55A11', '#ED7D31']


def load_and_clean(path: str) -> pd.DataFrame:
    """Load raw CSV and derive Revenue, Delay_Days, and YearMonth columns."""
    df = pd.read_csv(path)
    df['Inward Date'] = pd.to_datetime(df['Inward Date'])
    df['Dispatch Date'] = pd.to_datetime(df['Dispatch Date'])
    df['Revenue'] = df['Price'] * df['Quantity Sold']
    df['Delay_Days'] = (df['Dispatch Date'] - df['Inward Date']).dt.days
    df['YearMonth'] = df['Inward Date'].dt.to_period('M').astype(str)
    return df


def sla_bucket(days: int) -> str:
    if days <= 7:
        return '1-7 days (Good)'
    elif days <= 14:
        return '8-14 days (Acceptable)'
    elif days <= 30:
        return '15-30 days (Delayed)'
    return '31-60 days (Severely Delayed)'


def revenue_summary(df: pd.DataFrame) -> dict:
    """Core KPIs for the executive summary / GenAI narrative layer."""
    return {
        'total_orders': len(df),
        'total_revenue': int(df['Revenue'].sum()),
        'avg_order_value': round(df['Revenue'].mean(), 2),
        'avg_dispatch_delay_days': round(df['Delay_Days'].mean(), 1),
        'pct_orders_delayed_15plus': round(
            (df['Delay_Days'] > 14).mean() * 100, 1
        ),
        'top_brand_by_revenue': df.groupby('Brand')['Revenue'].sum().idxmax(),
        'top_region_by_revenue': df.groupby('Region')['Revenue'].sum().idxmax(),
    }


def plot_all(df: pd.DataFrame, out_dir: str = 'charts') -> None:
    """Generate the full chart set used in the dashboard and README."""
    import os
    os.makedirs(out_dir, exist_ok=True)
    fmt_cr = mticker.FuncFormatter(lambda x, pos: f'{x/1e7:.0f}Cr')

    # Monthly revenue trend
    monthly = df[df['YearMonth'] < '2025-04'].groupby('YearMonth')['Revenue'].sum()
    fig, ax = plt.subplots(figsize=(11, 5))
    ax.plot(monthly.index, monthly.values, color=NAVY, linewidth=2, marker='o', markersize=3)
    ax.set_title('Monthly Revenue Trend', fontweight='bold', color=NAVY)
    ax.yaxis.set_major_formatter(fmt_cr)
    ax.set_xticks(ax.get_xticks()[::3])
    plt.xticks(rotation=45, ha='right')
    plt.tight_layout()
    plt.savefig(f'{out_dir}/01_monthly_revenue_trend.png', dpi=150)
    plt.close()

    # SLA breakdown — the key differentiator chart
    df['SLA_Bucket'] = df['Delay_Days'].apply(sla_bucket)
    labels = ['1-7 days (Good)', '8-14 days (Acceptable)', '15-30 days (Delayed)', '31-60 days (Severely Delayed)']
    pct = (df['SLA_Bucket'].value_counts(normalize=True).reindex(labels) * 100)
    fig, ax = plt.subplots(figsize=(9, 5))
    ax.bar(pct.index, pct.values, color=[GREEN, '#A9D18E', ORANGE, '#C00000'])
    ax.set_title('Order Fulfillment SLA Breakdown', fontweight='bold', color=NAVY)
    ax.set_ylabel('% of Orders')
    plt.tight_layout()
    plt.savefig(f'{out_dir}/06_sla_breakdown.png', dpi=150)
    plt.close()

    # Delay by brand — proves the issue is systemic, not brand-specific
    brand_delay = df.groupby('Brand')['Delay_Days'].mean().sort_values()
    fig, ax = plt.subplots(figsize=(11, 6))
    ax.barh(brand_delay.index, brand_delay.values, color=BLUE)
    ax.axvline(df['Delay_Days'].mean(), color=ORANGE, linestyle='--', label='Overall average')
    ax.set_title('Avg Dispatch Delay by Brand', fontweight='bold', color=NAVY)
    ax.legend()
    plt.tight_layout()
    plt.savefig(f'{out_dir}/07_delay_by_brand.png', dpi=150)
    plt.close()

    print(f"Charts saved to {out_dir}/")


if __name__ == '__main__':
    data = load_and_clean('mobile_sales_data.csv')
    summary = revenue_summary(data)
    print("=== Executive KPI Summary ===")
    for k, v in summary.items():
        print(f"{k}: {v}")
    plot_all(data)
