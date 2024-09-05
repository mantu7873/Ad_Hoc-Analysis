-- Get the products that have the highest and lowest manufacturing costs. 
-- The final output should contain these fields product_code, product, manufacturing_cost

WITH high_mc AS(
		SELECT 
			p.product_code, p.product, m.manufacturing_cost
		FROM
			fact_manufacturing_cost AS m
				JOIN
			dim_product AS p ON m.product_code = p.product_code
		ORDER BY m.manufacturing_cost DESC
		LIMIT 1),
	low_mc AS(
		SELECT 
			p.product_code, p.product, m.manufacturing_cost
		FROM
			fact_manufacturing_cost AS m
				JOIN
			dim_product AS p ON m.product_code = p.product_code
		ORDER BY m.manufacturing_cost ASC
		LIMIT 1)
SELECT * FROM
    high_mc 
UNION SELECT * FROM
    low_mc;