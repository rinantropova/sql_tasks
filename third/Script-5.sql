-- Приджойним к данным о заказах данные о
--покупателях. Данные, которые нас интересуют —
--имя заказчика и страна, из которой совершается
--покупка.

SELECT o.CustomerID,
o.EmployeeID,
o.ShipperID,
o.OrderDate,
c.CustomerName,
c.Country 
FROM Orders o
join Customers c 
on c.CustomerID = o.CustomerID 




--Давайте проверим, Customer пришедшие из какой
--страны совершили наибольшее число Orders.
--Используем сортировку по убыванию по полю
--числа заказов.
--И выведем сверху в результирующей таблице
--название лидирующей страны.

SELECT
COUNT(o.OrderID) as orders_amount,
c.Country 
FROM Orders o
join Customers c 
on c.CustomerID = o.CustomerID 
GROUP BY c.Country 
ORDER BY orders_amount DESC 




--А теперь напишем запрос, который обеспечит
--целостное представление деталей заказа,
--включая информацию как о клиентах,
--так и о сотрудниках.
--Будем использовать JOIN для соединения
--информации из таблиц Orders, Customers
--и Employees.

SELECT o.OrderID,
o.OrderDate,
c.CustomerName,
c.Country, 
e.LastName 
FROM Orders o 
join Customers c 
ON c.CustomerID = o.CustomerID 
JOIN Employees e 
ON e.EmployeeID = o.EmployeeID 



--Наша следующая задача — проанализировать
--данные заказа, рассчитать ключевые показатели,
--связанные с выручкой, и соотнести результаты
--с ценовой информацией из таблицы Products.
--Давайте посмотрим на общую выручку, а также
--минимальный, максимальный чек в разбивке
--по странам.

SELECT SUM(od.Quantity * p.Price) as total_price,
MIN(od.Quantity * p.Price) as min_order,
MAX(od.Quantity * p.Price) as max_order,
c.Country 
FROM Customers c 
JOIN Orders o ON o.CustomerID = c.CustomerID 
JOIN OrderDetails od ON od.OrderID = o.OrderID 
JOIN Products p ON p.ProductID = od.ProductID 
GROUP BY c.Country 
ORDER BY total_price DESC 





--Выведем имена покупателей, которые совершили
--как минимум одну покупку 12 декабря

SELECT DISTINCT c.CustomerName 
FROM Customers c 
JOIN Orders o ON o.CustomerID = c.CustomerID 
WHERE o.OrderDate = '2023-12-12'




--Напишем SQL-запрос для создания отчета об исследовании продукта, показывающего потенциальный интерес к каждому продукту
--в разных странах. Используем CROSS JOIN операцию для создания комбинаций стран и продуктов.
--Это PotentialInterest должно представлять собой гипотетическую оценку, основанную на общем
--количестве клиентов из этой страны, которые могут быть заинтересованы в конкретном продукте.
--CROSS JOIN создаёт все возможные комбинации стран и названий продуктов.

SELECT c.Country,
p.ProductName,
p.Price,
COUNT(DISTINCT c.CustomerID) as PotentialInterest
FROM Customers c 
CROSS JOIN Products p 
GROUP BY c.Country, p.ProductName, p.Price 



--
--Давайте проанализируем разнообразие поставщиков в категориях продуктов.
--Напишем SQL-запрос для определения поставщиков, предлагающих широкий ассортимент продукции в разных категориях.

SELECT s.SupplierID,
s.SupplierName,
s.Country,
COUNT(DISTINCT p.CategoryID) as product_diversity 
FROM Suppliers s 
JOIN Products p ON p.SupplierID = s.SupplierID 
GROUP BY s.SupplierID, s.SupplierName, s.Country 
ORDER by product_diversity




--Ваша компания заинтересована в том, чтобы понять, в каких странах появились новые
--клиенты, которые еще не разместили заказы.
--Напишем SQL-запрос, позволяющий идентифицировать страны, в которых клиенты зарегистрировались, но не сделали заказов.

WITH Cust AS (SELECT c.* FROM Customers c 
EXCEPT
SELECT c.* FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID)
SELECT  country, count(DISTINCT customerid)
FROM Cust
GROUP BY country




--Представим, что Ваша компания хочет выявить клиентов, которые приобрели товары как
--стоимостью менее 30, так и стоимостью более 150 долларов США.
--Напишите запрос SQL, INTERSECT чтобы найти клиентов, которые делали покупки в обоих этих
--ценовых диапазонах.

SELECT c.CustomerID, c.CustomerName 
FROM Customers c 
JOIN Orders o on o.CustomerID = c.CustomerID 
JOIN OrderDetails od ON od.OrderID  = o.OrderID 
JOIN Products p ON p.ProductID = od.ProductID 
WHERE p.Price < 30
INTERSECT
SELECT c.CustomerID, c.CustomerName 
FROM Customers c 
JOIN Orders o on o.CustomerID = c.CustomerID 
JOIN OrderDetails od ON od.OrderID  = o.OrderID 
JOIN Products p ON p.ProductID = od.ProductID 
WHERE p.Price > 150




--Следующим запросом давайте создадим набор результатов, который включает уникальные
--записи о клиентах как для США, так и для Канады.
--В данном случае оператор UNION объединяет результаты двух отдельных запросов, представляя единый список клиентов из обеих
--стран, удаляя при этом любые дубликаты.

SELECT DISTINCT CustomerName, Country 
FROM Customers c 
WHERE Country = 'USA'
UNION 
SELECT DISTINCT CustomerName, Country 
FROM Customers c2 
WHERE Country = 'Canada'



