-- Задание №1: Уникальные страны клиентов
-- Определите, сколько уникальных стран представлено среди клиентов.
SELECT COUNT(DISTINCT Country) AS unique_countries_count FROM Customers c 
-- Answer: 21


-- Задание №2: Клиенты из Бразилии
-- Определите количество клиентов, которые проживают в Бразилии
SELECT COUNT(*) AS clients_from_brazil FROM Customers c 
WHERE Country = 'Brazil'
-- Answer: 9


-- Задание №3: Средняя цена и количество товаров в категории 5
-- Посчитайте среднюю цену и общее количество товаров в категории с идентификатором 5.
SELECT AVG(Price) AS mean_price, COUNT(*) AS products_amount FROM Products p 
WHERE CategoryID = 5
-- Answer: mean_price = 20.25, products_amount = 7


-- Задание №4: Средний возраст сотрудников на 2024-01-01
-- Вычислите средний возраст сотрудников на дату 2024-01-01.
SELECT AVG(age) AS average_age
FROM (
    SELECT (strftime('%Y', '2024-01-01') - strftime('%Y', BirthDate)) 
           - (strftime('%m-%d', '2024-01-01') < strftime('%m-%d', BirthDate)) AS age
    FROM Employees
) AS age_results;
-- Answer: 65.6



-- Задание №5: Заказы в период 30 дней до 2024-02-15
-- Найдите заказы, сделанные в период с 16 января по 15 февраля 2024 года, и отсортируйте их по дате заказа.
SELECT * FROM Orders o 
WHERE OrderDate BETWEEN '2024-01-16' AND '2024-02-15'
ORDER BY OrderDate 
-- Answer: Found 28 orders - first at 16.01.2024, last at 12.02.2024



-- Задание №6: Количество заказов за ноябрь 2023 года (используя начальную и конечную дату)
-- Определите количество заказов, сделанных в ноябре 2023 года, используя начальную и конечную дату месяца.
SELECT COUNT(*) FROM Orders o
WHERE OrderDate BETWEEN '2023-11-01' AND '2023-11-30'
-- Answer: 25



-- Задание №7: Количество заказов за январь 2024 года (используя LIKE)
-- Найдите количество заказов за январь 2024 года, используя оператор LIKE для фильтрации даты
SELECT COUNT(*) FROM 
	(SELECT strftime('%Y-%m-%d', OrderDate) AS OrderDateString
	FROM Orders
	WHERE strftime('%Y-%m-%d', OrderDate) LIKE '2024-01%');
-- Answer: 33



-- Задание №8: Количество заказов за 2024 год
-- Определите количество заказов за 2024 года, используя функцию STRFTIME для извлечения года
SELECT COUNT(*) AS orders_2024
FROM Orders
WHERE strftime('%Y', OrderDate) = '2024';
-- Answer: 44

