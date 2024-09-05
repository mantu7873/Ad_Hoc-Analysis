-- Follow-up: Which segment had the most increase in unique products in 2021 vs 2020? 
-- The final output contains these fields, segment product_count_2020 product_count_2021 difference

-- Solution 1
CREATE TEMPORARY TABLE products
	SELECT 
    m.product_code, m.cost_year, p.segment
FROM
    fact_manufacturing_cost AS m
        JOIN
    dim_product AS p ON m.product_code = p.product_code;

SELECT 
    p1.segment AS Segment,
    COALESCE(SUM(CASE WHEN p1.cost_year = 2020 THEN 1 ELSE 0 END), 0) AS Product_count_2020,
    COALESCE(SUM(CASE WHEN p1.cost_year = 2021 THEN 1 ELSE 0 END), 0) AS Product_count_2021,
    (COALESCE(SUM(CASE WHEN p1.cost_year = 2021 THEN 1 ELSE 0 END), 0) - 
     COALESCE(SUM(CASE WHEN p1.cost_year = 2020 THEN 1 ELSE 0 END), 0)) AS difference
FROM 
    products p1
GROUP BY 
    p1.segment
ORDER BY difference DESC;

-- Solution 2
with prod_2020 as(
		SELECT 
			p.segment AS Segment,
			COUNT(m.product_code) AS product_count_2020
		FROM
			fact_manufacturing_cost AS m
				JOIN
			dim_product AS p ON m.product_code = p.product_code
		WHERE
			m.cost_year = 2020
		GROUP BY p.segment),
	prod_2021 as(
		SELECT 
			p.segment AS Segment,
			COUNT(m.product_code) AS product_count_2021
		FROM
			fact_manufacturing_cost AS m
				JOIN
			dim_product AS p ON m.product_code = p.product_code
		WHERE
			m.cost_year = 2021
		GROUP BY p.segment)
SELECT 
	prod_2020.Segment,
    product_count_2020,
    product_count_2021,
    product_count_2021-product_count_2020 as difference
FROM prod_2020
JOIN prod_2021
ON prod_2020.Segment = prod_2021.Segment
ORDER BY difference DESC;