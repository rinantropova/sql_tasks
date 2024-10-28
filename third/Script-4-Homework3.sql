--Задание 1: Анализ прибыли по категориям продуктов
--Задание: Определите общую прибыль для каждой категории продуктов,
--используя таблицы OrderDetails, Orders и Products. Для расчета прибыли
--умножьте цену продукта на количество, а затем суммируйте результаты по
--категориям.

SELECT c.CategoryID,
SUM(p.Price * od.Quantity) as profit 
FROM OrderDetails od 
JOIN Orders o ON o.OrderID = od.OrderID 
JOIN Products p ON p.ProductID = od.ProductID 
JOIN Categories c ON c.CategoryID = p.CategoryID 
GROUP BY c.CategoryName 


--
--Задание 2: Количество заказов по регионам
--Задание: Определите количество заказов, размещенных клиентами из различных стран, за
--каждый месяц.
SELECT c.Country,
strftime('%m', o.OrderDate) AS month,
strftime('%Y', o.OrderDate) AS year,
COUNT(o.OrderDate) as order_count 
FROM Orders o 
JOIN Customers c ON c.CustomerID = o.CustomerID 
GROUP BY c.Country, month, year



--Задание 3: Средняя продолжительность кредитного срока для клиентов
--Задание: Рассчитайте среднюю продолжительность кредитного срока для
--клиентов по категориям образования.
SELECT education, ROUND(AVG(credit_term), 2) as avg_credit_term 
FROM Clusters c 
GROUP BY education 
ORDER BY avg_credit_term 




