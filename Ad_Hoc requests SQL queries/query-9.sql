-- Which channel helped to bring more gross sales in the fiscal year 2021 and the percentage of contribution? 
-- The final output contains these fields, channel, gross_sales_mln, percentage

WITH cte1 AS(
		SELECT 
			c.channel,
			SUM(s.sold_quantity * g.gross_price) AS gross_sales
		FROM
			fact_sales_monthly AS s
				JOIN
			fact_gross_price AS g ON s.product_code = g.product_code
				AND s.fiscal_year = g.fiscal_year
				JOIN
			dim_customer AS c ON s.customer_code = c.customer_code
		WHERE
			s.fiscal_year = 2021
		GROUP BY c.channel),
	cte2 AS(
		SELECT 
			SUM(gross_sales) AS total_gross_sales
		FROM
			cte1)
SELECT 
    channel, 
    round(gross_sales/1000000 , 2) as gross_sale_mln,
    round((gross_sales / total_gross_sales) * 100, 2) AS percentage
FROM
    cte1,
    cte2;