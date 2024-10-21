-- Провести первый анализ данных: посмотреть отдельно уникальные значения по полям sex (пол),
-- education (образование), product_type (тип продукта), family_status (семейное положение).
SELECT DISTINCT family_status from Clusters; 

-- Получить клиентов банка женщин, с семейным статусом Another
SELECT * FROM Clusters c 
WHERE family_status  = 'Another' AND sex = 'female';


-- Получите клиентов пенсионного возраста с сортировкой по полу и возрасту (женщины 60 лет
-- включительно, мужчины 65 лет).
SELECT * FROM Clusters c 
WHERE (sex = 'female' AND age >= 60) OR (sex = 'male' AND age >= 65)
ORDER BY sex DESC, age DESC;


-- Получите только женатых пенсионеров
SELECT * FROM Clusters c 
WHERE (sex = 'female' AND age >= 60 OR 
	sex = 'male' AND age >= 65) AND 
	family_status = 'Married'
ORDER BY  sex, age;


-- На какие цели берут кредит десять пенсионеров с наименьшим доходом.
SELECT product_type, income FROM Clusters c 
WHERE (sex = 'female' AND age >= 60) OR 
	(sex = 'male' AND age >= 65)
ORDER BY income
LIMIT 10;


-- Вывести первых 10 человек с наибольшей и наименьшей заработной платой (два запроса)
SELECT * FROM Clusters c 
ORDER BY income DESC 
LIMIT 10;


-- Вывести первых 10 человек с наибольшей разницей между доходом и запрашиваемым кредит.
-- То есть люди много зарабатывают и мало просят
SELECT *, income-credit_amount AS difference FROM Clusters c 
ORDER BY income-credit_amount DESC;


-- Получить список всех клиентов с образованием Higher education
SELECT * FROM Clusters c 
WHERE education = 'Higher education';


-- Получить список всех клиентов из третьего кластера с доходом больше 120000. Сколько таких клиентов?
SELECT * FROM  Clusters c 
WHERE cluster = 3 AND income > 120000;


-- Получить список клиентов из 3 и 5 кластера с доходом больше 120000 (нужны скобки при операции OR?).
-- Сколько сейчас таких клиентов?
SELECT * FROM Clusters c 
WHERE cluster IN (3, 5) AND income > 120000;


-- Выведите клиентов, у которых цель кредита заканчивается на ‘ces’
SELECT * FROM Clusters c 
WHERE product_type LIKE '%ces';


-- Получите клиентов, у которых в цели кредита есть как минимум две буквы n
SELECT * FROM Clusters c 
WHERE product_type LIKE '%n%n%'


-- Получите клиентов, у которых цель кредита менее 9 символов. Пояснение:
-- произвольный обязательный символ обозначается как подчеркивание.
-- Второе решение через LEN
SELECT * FROM Clusters c 
WHERE product_type NOT LIKE '%________%';

SELECT * FROM Clusters c 
WHERE LENGTH (product_type) < 9; 


-- Получите клиентов, у которых доход находится в пределах 20000 и 30000 (включительно)
SELECT * FROM Clusters c 
WHERE income >= 20000 AND income <= 30000
ORDER BY income DESC;

SELECT * FROM Clusters c 
WHERE income BETWEEN 20000 AND 30000
ORDER BY income DESC;


-- Получите новое поле из полей education, sex вида education(sex). Буквы привести к нижнему регистру.
-- Подсказка: Для соединения слов в MSSQL используется знак +, в других диалектах может использоваться || или concat()
SELECT CONCAT(LOWER(education), '(', LOWER(sex), ')') FROM Clusters c 


-- Сколько различных кредитных программ (credit_term) существует
SELECT COUNT(DISTINCT credit_term) AS amount_credit_terms FROM Clusters c 


-- Сколько различных целей кредитов (product_type) существует
SELECT COUNT(DISTINCT product_type) AS amount_product_type FROM Clusters c 


-- Посчитайте, сколько денег в декабре месяце просили всего (суммарно) клиенты банка.
SELECT SUM(credit_amount) FROM Clusters c
WHERE month = 12 AND is_client = 1


-- Определите переменные ‘2023-09-01’ ‘20-09-15’ и посчитайте, какое количество заказов было
-- сделано за этот период (включительно). Смотрим таблицу Orders.
WITH 
StartDate AS (SELECT '2023-09-01' AS date),
FinishDate AS (SELECT '2023-09-15' AS date)

SELECT COUNT(*) 
FROM Orders, StartDate, FinishDate
WHERE OrderDate BETWEEN StartDate.date AND FinishDate.date;



