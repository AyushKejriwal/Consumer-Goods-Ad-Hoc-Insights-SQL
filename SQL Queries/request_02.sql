/* 2.  What is the percentage of unique product increase in 2021 vs. 2020? 
	   The final output contains these fields: 
       unique_products_2020, 
       unique_products_2021, 
       percentage_chg
*/

WITH product_counts_20 AS (
	SELECT
		COUNT(DISTINCT product_code) AS unique_products_20
	FROM gdb023.fact_sales_monthly fsm
    WHERE fiscal_year = 2020
),
product_counts_21 AS (
	SELECT
		COUNT(DISTINCT product_code) AS unique_products_21
	FROM gdb023.fact_sales_monthly fsm
    WHERE fiscal_year = 2021
)

SELECT
	unique_products_21,
    unique_products_20,
    ROUND(
			(
				(unique_products_21 - unique_products_20) * 100 / unique_products_20
			)
		) AS percentage_chg
FROM product_counts_20
CROSS JOIN
	product_counts_21;
    