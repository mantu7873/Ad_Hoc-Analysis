-- Get the complete report of the Gross sales amount for the customer “Atliq Exclusive” for each month . 
-- This analysis helps to get an idea of low and high-performing months and take strategic decisions.
-- The final report contains these columns: Month, Year, Gross sales Amount

SELECT 
    MONTHNAME(date) AS Month,
    YEAR(date) AS Year,
    sum(sold_quantity * gross_price) AS gross_sale_amount
FROM
    fact_sales_monthly AS s
        JOIN
    fact_gross_price AS g ON s.product_code = g.product_code AND s.fiscal_year = g.fiscal_year
        JOIN
    dim_customer AS c ON s.customer_code = c.customer_code
WHERE
    c.customer = 'Atliq Exclusive'
GROUP BY Month , Year
ORDER BY gross_sale_amount DESC;