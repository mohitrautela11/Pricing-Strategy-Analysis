# Pricing-Strategy-Analysis
# The Daily Grind: Pricing Strategy Review

A pricing analysis I put together for a fictional coffee company (The Daily Grind), based on a request from management to look into why profit margins had been slipping.

**Live dashboard:** [https://public.tableau.com/views/SalesPricingAnalysis_17888101909590/SalesPricingDashBoard?:language=en-GB&:sid=&:redirect=auth&:display_count=n&:origin=viz_share_link]

## The Task

Management sent over an email saying margins had dropped across the portfolio, mostly because of rising COGS and tariffs, and asked the data team to dig into the 2023–2025 order data. Three things were needed:

1. Find every product with a Gross Margin % under 30% in Q3 2025
2. Build a dashboard covering Year-over-Year GMP, plus Revenue broken down by Category, Product, and Region
3. Give actual recommendations, not just a list, on what needs a price increase and what should be cut

## What I Did

I started in SQL Server, combining the three yearly order tables with a `UNION ALL`, then joined that against the customer and product tables. A few rows were missing revenue values, so I backfilled those using `Price × Quantity` and calculated profit as revenue minus COGS. That query is in [`SQLQuery.sql`](./SQLQuery.sql).

One snag: I was building the dashboard in Tableau Public, which doesn't let you connect live to SQL Server. So I exported the query results to a CSV [`Daily_grind.csv`](./Daily_grind.csv) and used that as the data source instead.

Once I had the margin numbers, I didn't want to just hand over a flat list of "these six products are below 30%." A product that's been struggling for two years and one that just had a rough quarter aren't the same problem, so I checked each flagged product against its full 2023–2025 performance too, not just Q3 2025. That split ended up being the whole point of the recommendation.

## What the Data Showed

Six products came in under 30% GMP in Q3 2025. Once I looked at their full-year numbers, they split cleanly into two groups:

| Product | Q3 2025 GMP | Full-Year GMP | Take |
|---|---|---|---|
| Chemex Filters (100 pack) | ~12% | ~16% | Consistently weak |
| Minimalist Keychain | ~12% | ~16% | Consistently weak |
| Logo Hoodie (Black) | ~12% | ~17% | Consistently weak |
| Gooseneck Electric Kettle | ~26% | ~29% | Under target both periods |
| Branded Ceramic Mug (Large) | ~28% | ~32% | Fine annually, dipped in Q3 |
| Pour-Over Starter Kit | ~29% | ~32% | Fine annually, dipped in Q3 |

## Recommendation

**Discontinue:** Chemex Filters, Minimalist Keychain, Logo Hoodie (Black). These aren't having a bad quarter, they're just consistently low margin, sitting somewhere in the 12–17% range no matter which time window you look at, and none of them brings in more than $850 a quarter. There's no real argument for fixing the price on these instead of just cutting them.

**Raise the price (2–4%):** Gooseneck Electric Kettle, Branded Ceramic Mug, Pour-Over Starter Kit. These are close to the 30% line, and two of the three are actually well above it once you zoom out to the full year. That points to the Q3 dip being tied to the COGS/tariff increase management mentioned, not a pricing problem with the product itself. A small price bump gets them back on target without needing to pull them from the shelf.

So out of six flagged products, three are genuinely underperforming and should go. The other three are otherwise solid, they just need a small correction to absorb the cost increase.

## Dashboard

Two tabs:
- **Overview** — the headline KPIs, the Gross Margin chart with a 30% reference line, YoY margin, revenue by category, and a regional revenue trend
- **Recommendations** — the write-up above, linked from the Overview page with a button

## Files

- `SQLQuery.sql` — the query that builds the cleaned dataset
- `Daily_grind.csv` — the exported output that Tableau actually reads from
- `customers.csv`, `products.csv`, `Orders_2023/2024/2025.csv` — raw source files
- `Sales_Pricing_Analysis.twbx` — the Tableau workbook
- `Task.png` — the original email/brief from management

## What This Shows

SQL (joins, UNION ALL, handling nulls), Tableau (calculated fields, reference lines, parameters, dashboard navigation), and thinking a step past "what does the data say" into "what should we actually do about it."
