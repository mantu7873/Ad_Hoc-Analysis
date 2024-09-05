-- Get the Top 3 products in each division that have a high total_sold_quantity in the fiscal_year 2021?
-- The final output contains these fields division, product_code, product, total_sold_quantity, rank_order

WITH cte1 AS(
		SELECT 
			p.division,
			p.product_code,
			p.product,
			SUM(s.sold_quantity) AS total_sold_quantity
		FROM
			fact_sales_monthly AS s
				JOIN
			dim_product AS p ON s.product_code = p.product_code
		GROUP BY p.division , p.product_code , p.product
		ORDER BY total_sold_quantity DESC),
	cte2 AS(
		SELECT *,
			RANK() OVER (PARTITION BY division ORDER BY total_sold_quantity DESC) AS rank_order
		FROM cte1 )
SELECT 
    *
FROM
    cte2
WHERE
    rank_order <= 3;