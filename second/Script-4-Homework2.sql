-- Вам необходимо проверить влияние семейного положения (family_status) на средний	доход
-- клиентов (income) и запрашиваемый кредит (credit_amount) .
SELECT family_status, ROUND(AVG(income), 1) as avg_income, ROUND(AVG(credit_amount), 1) AS avg_credit FROM Clusters c 
group by family_status 
ORDER by family_status ;
-- Answer: There is no much of an influence of family status on average income or credit value.


-- Сколько товаров в категории Meat/Poultry
SELECT COUNT(DISTINCT ProductName) FROM Products p 
WHERE CategoryID IN (SELECT CategoryID FROM Categories c 
WHERE CategoryName = 'Meat/Poultry')
-- Answer: 6



-- Какой товар (название) заказывали в сумме в самом большом количестве (sum(Quantity) в
-- таблице OrderDetails)
SELECT ProductName FROM Products p 
WHERE ProductID IN (SELECT ProductID FROM OrderDetails od 
Group by ProductID 
order by SUM(Quantity) DESC
LIMIT 1)
-- Answer: Gorgonzola Telino




-- Задание №1: Анализ влияния категорий продуктов на общий доход
SELECT
	p.CategoryID,
	SUM(od.Quantity) AS total_quantity,
	SUM(od.Quantity * p.Price) AS total_revenue
FROM OrderDetails od
JOIN Products p ON od.ProductID = p.ProductID
GROUP BY p.CategoryID
ORDER BY total_revenue DESC;
-- Answer: the most expensive category is the 1st one. 



--Задание №2: Анализ частоты заказа продуктов по категориям
SELECT p.CategoryID , COUNT(DISTINCT od.OrderID) as order_count 
FROM OrderDetails od 
JOIN Products p ON od.ProductID = p.ProductID 
GROUP BY p.CategoryID 
ORDER BY order_count DESC;
-- Answer: Category 1 and 3 are the most often ordered.


--Задание №3: Вывод наиболее популярных продуктов по количеству заказов
SELECT p.ProductName, SUM(od.Quantity) as total_quantity 
FROM OrderDetails od 
JOIN Products p ON od.ProductID = p.ProductID 
GROUP BY p.ProductName 
ORDER BY total_quantity DESC;
-- Answer: the most popular product based on the orders is Gorgonzola Telino

