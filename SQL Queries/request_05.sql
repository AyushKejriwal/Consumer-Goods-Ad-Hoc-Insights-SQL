/*5.Get the products that have the highest and lowest manufacturing costs. 
	The final output should contain these fields, 
	-product_code 
	-product 
	-manufacturing_cost
*/

SELECT 
	dp.product_code,
    dp.product,
    fmc.manufacturing_cost
FROM gdb023.fact_manufacturing_cost fmc
JOIN gdb023.dim_product dp 
	USING(product_code)
WHERE fmc.manufacturing_cost 
	IN (
		SELECT 
			MAX(manufacturing_cost)
		FROM gdb023.fact_manufacturing_cost
		
		UNION
		
		SELECT 
			MIN(manufacturing_cost)
		FROM gdb023.fact_manufacturing_cost
		)
ORDER BY fmc.manufacturing_cost DESC;

