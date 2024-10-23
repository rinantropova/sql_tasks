-- Давайте посмотрим сколько среди наших клиентов мужчин и женщин. А затем посмотрим как люди разбиты по образованию. 
SELECT education, COUNT(*) AS cnt FROM Clusters c 
GROUP BY education 
ORDER BY cnt DESC;


-- Теперь необходимо сравнить распределение по полу и образованию (отдельно) для клиентов и не клиентов банка.
-- Продумать, какая сортировка будет оптимальной.
SELECT sex, is_client, COUNT(*) AS cnt FROM Clusters c 
GROUP BY sex, is_client 
ORDER BY sex DESC , is_client ;

SELECT education , is_client, COUNT(*) AS cnt FROM Clusters c 
GROUP BY education , is_client 
ORDER BY education, is_client ;



-- Давайте посмотрим образование клиентов с разбивкой по полу и определим, какое образование самое непопулярное
-- у них (меньше всего ). То есть отфильтруем по количеству меньше 40
SELECT education, sex , COUNT(*) AS cnt FROM Clusters c 
WHERE is_client = 1
GROUP BY education , sex 
HAVING cnt < 40
ORDER BY cnt;



-- Получить среднюю величину запрашиваемого кредита и дохода клиентов для клиентов банка в разрезе образования и пола клиентов
SELECT sex, education, ROUND(AVG(income), 1) as avg_income, ROUND(AVG(credit_amount), 1) as avg_credit FROM Clusters c 
WHERE is_client = 1
GROUP BY sex, education 
ORDER BY sex, education;



-- Получить максимальную и минимальную сумму кредита в разрезе пола и Хороших клиентов для клиентов с высшим/неполным 
-- высшим образованием. В чем особенность плохих и хороших клиентов?
SELECT sex, bad_client_target, MAX(credit_amount) as max_credit, MIN(credit_amount) as min_credit FROM Clusters c 
WHERE education LIKE '%higher%'
GROUP BY sex, bad_client_target 
ORDER BY sex, bad_client_target;



-- Получить распределение (min, max, avg) возрастов клиентов в зависимости от пола и оператора связи
SELECT sex, phone_operator, MIN(age) as min_age, MAX(age) as max_age, ROUND(AVG(age),1) as avg_age FROM Clusters c 
GROUP BY sex, phone_operator 
ORDER BY sex, phone_operator;



-- Давайте поработаем с колонкой cluster. Для начала посмотрим сколько кластеров у нас есть и сколько
-- людей попало в каждый кластер
SELECT cluster, COUNT(*) AS cnt from Clusters c
GROUP BY cluster 
ORDER  BY cnt DESC ;



-- Видим, что есть большие кластеры 0, 4, 3. Остальные маленькие.
-- Давайте маленькие кластеры объединим в большой и посмотрим средний возраст, доход, кредит и пол в больших кластерах
-- (с помощью функции CASE). 
SELECT (CASE when cluster in (1, 5, 6, 2) then -1 else cluster END) AS new_cluster,
COUNT(*) AS cnt,
AVG(age),
AVG(income),
AVG(credit_amount),
AVG(case when sex='male' then 1.0 else 0 end) as avg_sex
FROM Clusters c 
group by new_cluster
ORDER by cnt;



--Давайте сейчас проверим гипотезу, что доход клиентов связан с регионом проживания. 
SELECT region, AVG(income) as avg_income FROM Clusters c
group by region 
ORDER BY avg_income DESC;



-- С помощью подзапроса получите заказы товаров из 4 и 6 категории (подзапрос в подзапросе).
-- Таблицы OrderDetails, Products
SELECT * FROM Orders 
WHERE OrderID in (SELECT OrderID FROM OrderDetails od 
WHERE ProductID in (SELECT ProductID FROM Products p 
WHERE CategoryID in (4, 6)));




-- В какие страны доставляет товары компания Speedy_Express
SELECT DISTINCT Country FROM Customers c 
WHERE CustomerID  in (SELECT CustomerID FROM Orders o 
WHERE  ShipperID  in (SELECT ShipperID FROM Shippers s 
WHERE ShipperName = 'Speedy_Express'))



-- Получите 3 страны, где больше всего клиентов (таблица Customers)
SELECT COUNT(*) as cnt, Country from Customers c 
group by Country 
order by cnt DESC 
LIMIT 3;



-- Назовите три самых популярных города и название страны среди трех популярных стран (где больше всего клиентов)
SELECT City, Country, COUNT(*) as cnt FROM Customers c 
WHERE Country IN (SELECT Country FROM Customers c
group by Country 
ORDER BY COUNT(*) DESC 
LIMIT 3)
GROUP BY City , Country
ORDER BY cnt DESC 
LIMIT 3;



-- 
