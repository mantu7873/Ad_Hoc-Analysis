-- Provide a report with all the unique product counts for each segment and sort them in descending order of product counts. 
-- The final output contains 2 fields, segment product_count

SELECT 
    segment AS Segment, COUNT(product_code) AS Product_count
FROM
    dim_product
GROUP BY segment
ORDER BY Product_count DESC;