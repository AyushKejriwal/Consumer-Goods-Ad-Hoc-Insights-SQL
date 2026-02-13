/*8.In which quarter of 2020, got the maximum total_sold_quantity? The final output 
	contains these fields sorted by the total_sold_quantity, 
	-Quarter 
	-total_sold_quantity
*/

WITH quater_data_2020 AS (
	SELECT 
		*,
		CONCAT('Q',CEIL(MONTH(DATE_ADD(date, INTERVAL 4 MONTH))/3),'-', fiscal_year) AS fiscal_quater
	FROM gdb023.fact_sales_monthly
    WHERE fiscal_year = 2020
)

SELECT 
    fiscal_quater,
    CONCAT( CAST(ROUND(SUM(sold_quantity)/1000000,2) AS CHAR), 'M' ) AS total_sold_quantity
FROM quater_data_2020
GROUP BY fiscal_quater
ORDER BY total_sold_quantity DESC;

