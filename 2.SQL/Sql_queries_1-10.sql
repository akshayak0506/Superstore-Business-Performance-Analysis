--1) Revenue & Profit by Year

SELECT
    year,
    ROUND(SUM(sales),2) AS revenue,
    ROUND(SUM(profit),2) AS profit
FROM orders
GROUP BY year
ORDER BY year;

--2) Quarterly Profit Trend

SELECT quarter,
       ROUND(SUM(profit),2)
FROM orders
GROUP BY quarter
ORDER BY quarter

-- 3) Loss-Making Sub-Categories

SELECT
    sub_category,
    ROUND(SUM(profit),2) AS total_profit
FROM orders
GROUP BY sub_category
ORDER BY total_profit ASC;

-- 4) Discount Impact Analysis

SELECT
    CASE
        WHEN discount = 0 THEN 'No Discount'
        WHEN discount <= 0.2 THEN 'Low (0–20%)'
        WHEN discount <= 0.5 THEN 'Medium (20–50%)'
        ELSE 'High (>50%)'
    END AS discount_bucket,
    ROUND(SUM(profit),2) AS total_profit
FROM orders
GROUP BY discount_bucket
ORDER BY total_profit DESC;

--5) Top 10 Customers by Profit

SELECT
    customer_name,
    ROUND(SUM(profit),2) AS total_profit
FROM orders
GROUP BY customer_name
ORDER BY total_profit DESC
LIMIT 10;

-- 6) High-Revenue but Low-Profit Products

SELECT
    product_name,
    ROUND(SUM(sales), 2) AS total_revenue,
    ROUND(SUM(profit), 2) AS total_profit
FROM orders
GROUP BY product_name
HAVING SUM(sales) > 10000
   AND SUM(profit) < 0
ORDER BY total_profit ASC;

--7) Profit Margin by Sub-Category

SELECT
    sub_category,
    ROUND(SUM(profit) / SUM(sales) * 100, 2) AS profit_margin_pct
FROM orders
GROUP BY sub_category
ORDER BY profit_margin_pct ASC;

--8) Loss Contribution Analysis

WITH loss_data AS (
    SELECT
        sub_category,
        SUM(profit) AS total_profit
    FROM orders
    GROUP BY sub_category
)
SELECT
    sub_category,
    ROUND(total_profit, 2) AS loss_amount,
    ROUND(
        total_profit / SUM(total_profit) OVER () * 100,
        2
    ) AS loss_contribution_pct
FROM loss_data
WHERE total_profit < 0
ORDER BY loss_amount ASC;

--9) Region-Wise Discount vs Profit

SELECT
    region,
    ROUND(AVG(discount), 2) AS avg_discount,
    ROUND(SUM(profit), 2) AS total_profit
FROM orders
GROUP BY region
ORDER BY total_profit ASC;

--10) Profitability by Customer Segment

SELECT
    segment,
    ROUND(SUM(sales), 2) AS revenue,
    ROUND(SUM(profit), 2) AS profit,
    ROUND(SUM(profit) / SUM(sales) * 100, 2) AS profit_margin_pct
FROM orders
GROUP BY segment
ORDER BY profit DESC;




