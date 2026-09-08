
--Combining the order Years
WITH all_orders AS (
    SELECT OrderID, CustomerID, ProductID, OrderDate, Quantity, Revenue, COGS
    FROM Orders_2023

    UNION ALL

    SELECT OrderID, CustomerID, ProductID, OrderDate, Quantity, Revenue, COGS
    FROM Orders_2024

    UNION ALL

    SELECT OrderID, CustomerID, ProductID, OrderDate, Quantity, Revenue, COGS
    FROM Orders_2025
)

--Building The main dataset Query
SELECT 
a.orderID,
a.CustomerID,
c.Region,
a.ProductID,
a.OrderDate,
c.CustomerJoinDate,
a.Quantity,
a.Revenue,
CASE WHEN a.Revenue IS NULL THEN p.Price * a.Quantity ELSE a.Revenue END AS Cleaned_Revenue,
CASE WHEN a.Revenue IS NULL THEN (p.Price * a.Quantity) - a.COGS ELSE a.Revenue - a.COGS END AS Profit,
a.COGS,
p.ProductName,
p.ProductCategory,
p.Price,
p.Base_Cost
FROM all_orders AS a 
LEFT JOIN
customers AS c
ON a.CustomerID = c.CustomerID 
LEFT JOIN
products AS p
ON a.ProductID = p.ProductID
WHERE c.CustomerID IS NOT NULL --Removing the Null Customer ids 

