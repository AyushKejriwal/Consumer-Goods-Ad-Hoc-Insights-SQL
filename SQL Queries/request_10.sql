/*10.Get the Top 3 products in each division that have a high 
	total_sold_quantity in the fiscal_year 2021? The final output 
	contains these: 
	-fields, 
	-division 
	-product_code 
	-product 
	-total_sold_quantity 
	-rank_order 
*/

WITH base_data AS (
	SELECT 
		dp.division
        ,dp.product_code
        ,dp.product
        ,SUM(fsm.sold_quantity) as total_sold_quantity,
        RANK() 	OVER(PARTITION BY division ORDER BY SUM(fsm.sold_quantity) DESC ) AS rank_order
	FROM gdb023.fact_sales_monthly fsm
	JOIN gdb023.dim_product dp USING(product_code)
	WHERE fiscal_year = 2021
	GROUP BY dp.division, dp.product_code, dp.product
)

SELECT * FROM base_data
WHERE rank_order < 4;