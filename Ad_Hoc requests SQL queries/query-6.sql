-- Generate a report which contains the top 5 customers who received an average high pre_invoice_discount_pct 
-- for the fiscal year 2021 and in the Indian market. The final output contains these fields,
-- customer_code, customer, average_discount_percentage

SELECT 
    c.customer_code,
    c.customer,
    round(AVG(pre_invoice_discount_pct), 3) AS average_discount_pct
FROM
    dim_customer AS c
        JOIN
    fact_pre_invoice_deductions AS pi ON c.customer_code = pi.customer_code
WHERE
    fiscal_year = 2021 AND market = 'india'
GROUP BY c.customer_code , c.customer
ORDER BY average_discount_pct DESC
LIMIT 5;