# Inventory Intelligence & Supply Chain Analytics

A Power BI portfolio project exploring inventory levels, replenishment signals, supplier lead times, estimated sales, and demand forecasting.

## Project Overview

The goal is to turn row-level supply-chain observations into an interactive dashboard for exploring inventory and demand patterns, comparing recorded lead times, and identifying records that meet a reorder-point rule.

**Data note:** The source dataset is synthetic. Results are exploratory and should not be interpreted as audited business performance or proof of causal impact.

## Business Questions

- How do estimated sales values vary over time and across regions?
- How do recorded inventory levels compare with reorder points?
- Which regions have larger absolute differences between units sold and demand forecasts?
- How do recorded supplier lead times compare?
- Which SKU and warehouse records meet the project's reorder rule?

## Dashboard Pages

1. **Executive Overview** — headline KPIs, sales trend, estimated sales by region, and inventory-status record counts.
2. **Inventory & Replenishment** — inventory versus reorder points, inventory by warehouse, and actual units sold versus forecast.
3. **Demand & Forecast Analysis** — forecast MAE by region, supplier lead-time comparison, actual demand versus forecast, and supporting KPIs.
4. **SKU & Operational Insights** — inventory level by SKU, reorder-alert records by warehouse, SKU-level details, and Region/Warehouse/Date slicers.

## Tools and Technologies

- **Power BI** — report visuals, KPI cards, slicers, and interactive filtering.
- **SQLite / DB Browser for SQLite** — data inspection, SQL view creation, and data preparation.
- **SQL** — date conversion, numeric casting, derived fields, and reorder-status logic.
- **CSV** — prepared dataset loaded into Power BI.

## Data Preparation

The raw CSV was imported into SQLite as `raw_inventory`. A view named `vw_inventory_analysis` was created to:

- Convert dates from `DD-MM-YYYY` to `YYYY-MM-DD`.
- Cast numeric fields to suitable numeric types.
- Calculate `sales_value` as `Units_Sold × Unit_Price`.
- Calculate `estimated_cogs` as `Units_Sold × Unit_Cost`.
- Calculate forecast error and absolute forecast error.
- Assign `Reorder Alert` when `Inventory_Level <= Reorder_Point`; otherwise assign `Sufficient Inventory`.

The prepared view was exported to `data/processed/inventory_analysis.csv` and imported into Power BI.

## Metric Definitions

- **Estimated sales value:** `Units_Sold × Unit_Price`; an estimate based on the dataset's field definitions.
- **Estimated COGS:** `Units_Sold × Unit_Cost`; also an estimate.
- **Estimated gross profit:** estimated sales value minus estimated COGS, if implemented that way in the report.
- **Forecast error:** `Units_Sold − Demand_Forecast`.
- **Absolute forecast error:** absolute value of forecast error.
- **Forecast MAE:** average absolute forecast error across selected records, provided the Power BI measure uses the prepared absolute-error column correctly.
- **Reorder alert:** a row-level rule that flags records where inventory is at or below the reorder point.
- **Average recorded lead time:** average of the supplied lead-time field; it does not measure actual delivery performance.

## Data Limitations

- The dataset is synthetic and may not reflect real-world operational conditions.
- `Stockout_Flag` is zero for all 91,250 rows in the inspected data, so it cannot support meaningful stockout-event analysis.
- SKU/warehouse combinations have repeated daily records. Summing `Inventory_Level` across dates gives a sum of observations, not a current-stock snapshot. Use averages or a clearly selected date for inventory comparisons.
- Reorder-alert counts represent row/record counts unless the report explicitly uses distinct SKU or SKU-warehouse counts.
- No actual delivery timestamps were identified, so on-time delivery performance cannot be measured from this dataset.
- Sales, COGS, and profit should be treated as estimated values until source definitions are independently confirmed.
- Promotion comparisons are descriptive and do not establish that promotions caused a change in sales.

## Suggested Folder Structure

```text
Inventory-Intelligence/
├── data/
│   ├── raw/
│   │   └── supply_chain_dataset1.csv
│   └── processed/
│       └── inventory_analysis.csv
├── sql/
├── powerbi/
├── screenshots/
├── inventory_intelligence.db
└── README.md
```

## How to Reproduce

1. Place the source CSV in `data/raw/`.
2. Import it into SQLite as `raw_inventory`.
3. Create the `vw_inventory_analysis` view using the SQL transformation script.
4. Export the view to `data/processed/inventory_analysis.csv`.
5. Open the Power BI `.pbix` report and refresh the prepared CSV data source.
6. Use the four report pages and the Region, Warehouse, and Date slicers to explore the data.

## Portfolio Notes

Before publishing, include screenshots of each report page and the `.pbix` file if you are comfortable sharing it. Do not describe this synthetic-data project as a deployed production system or claim verified financial improvements.

## Author

Add your name and portfolio links here.
