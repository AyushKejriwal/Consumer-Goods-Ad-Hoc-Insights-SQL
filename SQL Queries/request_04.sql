/*4.Follow-up: Which segment had the most increase in unique products in 2021 vs 2020? 
	The final output contains these fields, 
	 -segment 
	 -product_count_2020 
	 -product_count_2021 
	 -difference
*/

WITH product_segment_data AS (
    SELECT 
        dp.segment,
        fsm.fiscal_year,
        COUNT(DISTINCT dp.product_code) AS product_counts
    FROM gdb023.dim_product dp
    JOIN gdb023.fact_sales_monthly fsm
        USING(product_code)
    WHERE fsm.fiscal_year IN (2020, 2021)
    GROUP BY dp.segment, fsm.fiscal_year
)

SELECT
    segment,
    MAX(CASE WHEN fiscal_year = 2020 THEN product_counts END) AS product_count_2020,
    MAX(CASE WHEN fiscal_year = 2021 THEN product_counts END) AS product_count_2021,
    COALESCE(MAX(CASE WHEN fiscal_year = 2021 THEN product_counts END),0)
    -
    COALESCE(MAX(CASE WHEN fiscal_year = 2020 THEN product_counts END),0)
    AS difference
FROM product_segment_data
GROUP BY segment
ORDER BY difference DESC;
