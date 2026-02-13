/*7.Get the complete report of the Gross sales amount for the customer “Atliq Exclusive” 
	for each month. This analysis helps to  get an idea of low and high-performing months 
	and take strategic decisions. The final report contains these columns: 
	-Month 
	-Year 
	-Gross sales Amount
*/
SELECT
	MONTH(fsm.date) AS Month,
    YEAR(fsm.date) AS Year,
    ROUND(SUM(fgp.gross_price * fsm.sold_quantity),2) AS Gross_sales_Amount
FROM gdb023.fact_sales_monthly fsm
JOIN gdb023.fact_gross_price fgp
	USING(product_code, fiscal_year)
WHERE fsm.customer_code IN (
		SELECT 
			DISTINCT(customer_code)
		FROM dim_customer dc 
		WHERE dc.customer = "Atliq Exclusive"
	)
GROUP BY fsm.date
ORDER BY fsm.date;