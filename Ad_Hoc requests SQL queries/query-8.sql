-- In which quarter of 2020, got the maximum total_sold_quantity? 
-- The final output contains these fields sorted by the total_sold_quantity, Quarter, total_sold_quantity

SELECT 
    CONCAT('Q',
            CEIL(MONTH(DATE_ADD(date, INTERVAL 4 MONTH)) / 3)) AS Quarter,
    SUM(sold_quantity) AS Sold_Quantity
FROM
    fact_sales_monthly
WHERE
    fiscal_year = 2020
GROUP BY Quarter
ORDER BY Sold_Quantity DESC;