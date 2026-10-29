/*
PROJECT: Inventory Intelligence & Supply Chain Analytics
PURPOSE: SQL analysis for inventory and replenishment.

NOTE:
This is a reconstructed portfolio script, not the original
SQL used to create the project's Power BI dataset.

Expected source table: raw_inventory
Verify column names against your actual dataset before running.
*/

-- 1. Inspect the source data
SELECT *
FROM raw_inventory
LIMIT 10;

-- 2. Check the number of records
SELECT COUNT(*) AS total_records
FROM raw_inventory;

-- 3. Analyze average inventory by warehouse
SELECT
    warehouse,
    AVG(inventory_level) AS average_inventory
FROM raw_inventory
GROUP BY warehouse
ORDER BY average_inventory DESC;

-- 4. Identify records at or below the reorder point
SELECT *
FROM raw_inventory
WHERE inventory_level <= reorder_point;

-- 5. Compare actual demand with forecast demand
SELECT
    SUM(units_sold) AS total_units_sold,
    SUM(units_ordered) AS total_units_ordered
FROM raw_inventory;