/*9.Which channel helped to bring more gross sales in the fiscal year 2021 and 
	the percentage of contribution? The final output contains these fields: 
	-channel 
	-gross_sales_mln 
	-percentage
*/

WITH sales_detail AS( 
	SELECT
		dc.channel,
        SUM(fgp.gross_price * fsm.sold_quantity) AS gross_sales
	FROM gdb023.fact_sales_monthly AS fsm
    JOIN gdb023.fact_gross_price AS fgp
		USING(product_code, fiscal_year)
	JOIN gdb023.dim_customer AS dc
		USING(customer_code)
	WHERE fsm.fiscal_year = 2021
    GROUP BY channel
)

SELECT
	channel,
    ROUND(gross_sales / 1e6, 2) AS gross_sales_mln,
    ROUND(gross_sales * 100 / SUM(gross_sales) OVER(), 2) AS percentage
    FROM sales_detail
    ORDER BY gross_sales DESC;
