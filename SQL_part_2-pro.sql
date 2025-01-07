﻿--Найдите пары моделей PC, имеющих одинаковые скорость и RAM. В результате каждая пара указывается только один раз, т.е. (i,j), но не (j,i),
--Порядок вывода: модель с большим номером, модель с меньшим номером, скорость и RAM.
--SELECT DISTINCT
--pc1.model
--,pc2.model
--,pc1.speed
--,pc1.ram
--FROM pc pc1
--JOIN pc pc2 ON pc1.speed = pc2.speed AND pc1.ram = pc2.ram
--WHERE pc1.model > pc2.model
--ORDER BY pc1.model asc


--#1 TRIM Задача 1: Получите имена покупателей, без начальных и конечных пробелов, и отобразите их вместе с их датами рождения.

--SELECT
--TRIM(CONCAT(b.buyer_name, ' ', FORMAT(b.birthday, 'dd-MM-yyyy'), ' ', 'год рождения')) AS [trimmed_concated]
--FROM study.buyers b

--Задача 2: Выведите все заказы, убрав пробелы в начале и конце названия продукта.
--DATALENGTH(): Эта функция учитывает все символы, включая пробелы и невидимые символы, а не только видимые.
--LEN() только видимые И ПРОБЕЛЫ ПЕРЕД СТРОКОЙ И МЕЖДУ СЛОВАМИ В КОНЦЕ НЕ ВИДИТ

--SELECT
--o.*
--,TRIM(pr.product_name) AS [product_name_no_white_spaces]
--FROM study.orders o
--JOIN study.orders_productsNN nn ON o.order_id = nn.order_id
--JOIN study.products pr ON nn.product_id = nn.product_id
--WHERE DATALENGTH(pr.product_name) <> DATALENGTH(TRIM(pr.product_name));

--SELECT
--o.*
--,pr.product_name
--FROM study.orders o
--JOIN study.orders_productsNN nn ON o.order_id = nn.order_id
--JOIN study.products pr ON nn.product_id = pr.product_id
----WHERE DATALENGTH(pr.product_name)<> DATALENGTH(TRIM(pr.product_name))
--WHERE LEN(pr.product_name) <> LEN(TRIM(pr.product_name))

--SELECT
--o.*
--,pr.product_name
--FROM study.orders o
--JOIN study.orders_productsNN nn ON o.order_id = nn.order_id
--JOIN study.products pr ON nn.product_id = pr.product_id
--WHERE pr.product_name like '% '

--DECLARE @ExString VARCHAR(100) = '  Hello world';
--SELECT DATALENGTH(@ExString) AS Length

--#2 LOWER Задача
--Задача 1: Выведите имена всех покупателей в нижнем регистре.
--SELECT
--LOWER(b.buyer_name)
--FROM study.buyers b

--Задача 2: Получите список названий всех продуктов в нижнем регистре, которые были заказаны.
--SELECT 
--LOWER(pr.product_name)
--,o.order_id
--,o.order_number
--FROM study.orders o
--JOIN study.orders_productsNN nn ON o.order_id = nn.order_id
--RIGHT JOIN study.products pr ON nn.product_id = pr.product_id
--WHERE o.order_id IS NOT NULL
--ORDER BY pr.product_id

--#3 UPPER
--Задача 1: Выведите имена всех покупателей в верхнем регистре
--SELECT
--UPPER(b.buyer_name)
--FROM study.buyers b

--Задача 2: Получите список названий всех продуктов в верхнем регистре, которые были заказаны.
--SELECT
--UPPER(pr.product_name)
--,o.order_id
--,o.order_number
--FROM study.orders o
--JOIN study.orders_productsNN nn ON o.order_id = nn.order_id
--JOIN study.products pr ON nn.product_id = pr.product_id
--#4 LEN
-- Задача 1: Выведите длину имени каждого покупателя, пробелы и точки не считаем .
--SELECT
--b.buyer_name
--,LEN(REPLACE(REPLACE(b.buyer_name,' ',''), '.', ''))
--FROM study.buyers b
--Задача 2: Получите длину описания каждого продукта.
--SELECT
--pr.description
--,LEN(REPLACE(REPLACE(pr.[description],' ',''),'.', ' '))
--FROM study.products pr
--WHERE pr.[description] IS NOT NULL

--#5 LEFT
--Задача 1: Извлеките первые 5 символов имен всех покупателей.
--SELECT 
--b.buyer_name
--,LEFT(b.buyer_name,5)
--FROM study.buyers b
--Задача 2: Получите первые 10 символов названий всех продуктов, которые были заказаны.
--SELECT
--pr.product_name
--,LEFT(TRIM(pr.product_name), 10) AS left_product_name
--FROM study.orders o
--JOIN study.orders_productsNN nn ON o.order_id = nn.order_id
--JOIN study.products pr ON nn.product_id = pr.product_id

--#6 RIGHT
--Задача 1: Извлеките последние 4 символа имен всех покупателей.
--SELECT 
--b.buyer_name
--,RIGHT(REPLACE(REPLACE(b.buyer_name,' ',''), '.', ''),4) AS [RIGHT_buyer_name]
--FROM study.buyers b
--Задача 2: Получите последние 3 символа названий продуктов, которые были заказаны.
--SELECT
--pr.product_id
--,pr.product_name
--,RIGHT(REPLACE(pr.product_name,' ',''),3) AS [RIGHT_product_name]
--FROM study.orders o
--JOIN study.orders_productsNN nn ON o.order_id = nn.order_id
--JOIN study.products pr ON nn.product_id = pr.product_id

--#7 SUBSTRING
--Задача 1: Извлеките подстроку из имени каждого покупателя, начиная с 3-го символа и длиной 2 символов.
--SELECT
--b.buyer_name
--,SUBSTRING(b.buyer_name,3,2) AS substring_buyer_name
--FROM study.buyers b
--Задача 2: Получите подстроку названия продукта, начиная с 2-го символа и длиной 3 символа для всех заказов.
--SELECT
--pr.product_name
--,SUBSTRING(TRIM(pr.product_name),2,3) AS [SUBSTRING_product_name]
--FROM study.products pr
--JOIN study.orders_productsNN nn ON pr.product_id = nn.product_id
--JOIN study.orders o ON nn.order_id = o.order_id

--#8 REPLACE
--Задача 1: Замените все пробелы в именах покупателей на подчеркивания. 
--SELECT
--b.buyer_name
--,REPLACE(b.buyer_name,' ', '_') AS [REPLACE_buyer_name]
--FROM study.buyers b
--Задача 2: Замените часть строки в описании продуктов, например, 'плата' на 'устройство'.
--SELECT
--pr.description
--,REPLACE(pr.description, 'слота', 'разъема') AS REPLACE_description
--FROM study.products pr

--#9 REPLICATE
--Задача 1: Повторите первый символ имени каждого покупателя 3 раза.
--SELECT
--*
--,REPLICATE(LEFT(b.buyer_name,1),2) AS [REPLICATE_buyer_name]
--FROM study.buyers b
--SELECT
--*
--,REPLICATE(SUBSTRING(b.buyer_name,1,1),3) AS [REPLICATE_buyer_name]
--FROM study.buyers b
--Задача 2: Создайте строку из названия продукта, повторяя его дважды, для всех заказов.
--SELECT
--REPLICATE(pr.product_name + '_',2) AS REPLICATE_product_name
--FROM study.orders o
--JOIN study.orders_productsNN nn ON o.order_id = nn.order_id
--JOIN study.products pr ON nn.product_id = nn.product_id

--#10 REVERSE
--Задача 1: Выведите имена покупателей в обратном порядке.
--SELECT
--REVERSE(b.buyer_name) AS [REVERSE_bueyr_name]
--FROM study.buyers b
--Задача 2: Получите названия продуктов в обратном порядке для всех заказов.
--SELECT
--REVERSE(pr.product_name) AS [REVERSE_product_namee]
--FROM study.orders o
--JOIN study.orders_productsNN nn ON o.order_id = nn.order_id
--JOIN study.products pr ON nn.product_id = pr.product_id

--SELECT
--p.product_name
--,p.type_id
--,SUM(o.order_summa)	OVER (PARTITION BY p.type_id) AS orders_summa_type_id
--,p.product_id
--,SUM(o.order_summa) OVER (PARTITION BY p.product_id) AS orders_summa_product_id100
--, CASE WHEN o.order_summa <> 0 THEN o.order_summa / p.price ELSE 0 END AS quantity
--,o.order_number
--,o.order_summa
--FROM study.orders o
--JOIN study.orders_productsNN nn ON nn.order_id = o.order_id
--RIGHT JOIN study.products p ON  nn.product_id = p.product_id 

--*****ОКОННЫЕ ФУНКЦИИ*****
--1. ROW_NUMBER()
--Задание 1: Напишите запрос, который выводит список покупателей с их заказами, пронумерованными по дате заказа в порядке убывания для каждого покупателя.
--SELECT
--b.buyer_name
--,o.order_number
--,o.order_date
--,ROW_NUMBER() OVER (PARTITION BY b.buyer_id ORDER BY o.order_date desc) AS [ROW_NUMBER]
--FROM study.buyers b
--JOIN study.orders o ON b.buyer_id = o.buyer_id

--Задание 2: Создайте отчет о количестве заказов каждого покупателя и присвойте каждому покупателю порядковый номер на основе количества его заказов.
--WITH buyers_order_count AS(
--SELECT 
--b.buyer_name
--,COUNT(o.order_number) AS order_count
--FROM study.buyers b
--JOIN study.orders o ON o.buyer_id = b.buyer_id
--GROUP BY b.buyer_name
--)
--SELECT
--bc.buyer_name
--,bc.order_count
--,ROW_NUMBER() OVER (ORDER BY bc.order_count) AS serial_number
--FROM buyers_order_count bc

--Задание 3: Выведите первые 3 заказа каждого покупателя, используя ROW_NUMBER() для ограничения результатов.
WITH buers_order_count AS( 
SELECT
b.buyer_id
,b.buyer_name
,o.order_number
,ROW_NUMBER() OVER (PARTITION BY b.buyer_id ORDER BY o.order_number) AS [row_number]
FROM study.buyers b
JOIN study.orders o ON o.buyer_id = b.buyer_id) 
SELECT
bo.buyer_name
,bo.order_number
,bo.row_number
FROM buers_order_count bo
WHERE bo.row_number in(1,2,3)


