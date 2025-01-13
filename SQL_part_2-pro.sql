--Найдите пары моделей PC, имеющих одинаковые скорость и RAM. В результате каждая пара указывается только один раз, т.е. (i,j), но не (j,i),
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
--,SUM(o.order_summa) OVER (PARTITION BY p.product_id) AS orders_summa_product_id
--, CASE WHEN o.order_summa <> 0 THEN o.order_summa / p.price ELSE 0 END AS quantity
--,o.order_number
--,o.order_summa
--FROM study.orders o
--JOIN study.orders_productsNN nn ON nn.order_id = o.order_id
--RIGHT JOIN study.products p ON  nn.product_id = p.product_id


--***************************************************************************************************ОКОННЫЕ ФУНКЦИИ**************************************************************************************************************************************************


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
--WITH buers_order_count AS( 
--SELECT
--b.buyer_id
--,b.buyer_name
--,o.order_number
--,ROW_NUMBER() OVER (PARTITION BY b.buyer_id ORDER BY o.order_number) AS [row_number]
--FROM study.buyers b
--JOIN study.orders o ON o.buyer_id = b.buyer_id) 
--SELECT
--bo.buyer_name
--,bo.order_number
--,bo.row_number
--FROM buers_order_count bo
--WHERE bo.row_number in(1,2,3)

--### 2. **RANK()**
--   - **Задание 1**: Напишите запрос, который выводит суммы заказов по покупателям и присваивает ранг на основе общей суммы заказов.
--WITH buyers_orders_sum AS
--(SELECT
--b.buyer_id
--,b.buyer_name
--,SUM(o.order_summa) AS order_sum
--FROM study.buyers b
--JOIN study.orders o ON o.buyer_id = b.buyer_id
--GROUP BY b.buyer_id, b.buyer_name
--) 
--SELECT
--bo.*
--, RANK() OVER (ORDER BY bo.order_sum DESC) AS Rank
--FROM buyers_orders_sum bo

--   - **Задание 2**: Создайте отчет о товарах, проданных по каждому заказу, и назначьте ранг товарам в зависимости от их цены (в рамках каждого заказа).
--SELECT
--RANK() OVER (PARTITION BY o.order_id ORDER BY pr.price DESC) AS Rank
--,o.order_id
--,o.order_number
--,pr.product_name
--,pr.price
--FROM study.orders o
--JOIN study.orders_productsNN nn ON nn.order_id = o.order_id
--JOIN study.products pr ON pr.product_id = nn.product_id


--   - **Задание 3**: Определите, какие покупатели получили самый высокий ранг по количеству заказов и выведите список этих покупателей.
--WITH buyers_orders_count AS (
--    SELECT
--        b.buyer_id,
--        b.buyer_name,
--        COUNT(o.order_number) AS orders_count
--    FROM study.buyers b 
--    JOIN study.orders o ON o.buyer_id = b.buyer_id
--    GROUP BY b.buyer_id, b.buyer_name
--),
--ranked_buyers AS (
--    SELECT
--        boc.buyer_id,
--        boc.buyer_name,
--        boc.orders_count,
--        RANK() OVER (ORDER BY boc.orders_count DESC) AS [rank]
--    FROM buyers_orders_count boc
--)
--SELECT
--    rb.buyer_id,
--    rb.buyer_name,
--    rb.orders_count,
--    rb.[rank]
--FROM ranked_buyers rb
--WHERE rb.[rank] = 1;  


--### 3. **DENSE_RANK()**
--   - **Задание 1**: Выведите список продуктов по цене, присваивая им плотный ранг в зависимости от их стоимости.
--SELECT
--pr.product_id
--,pr.product_name
--,pr.description
--,pr.price
--,DENSE_RANK() OVER (ORDER BY pr.price DESC) AS [DENSE_RANK]
--FROM study.products pr

--   - **Задание 2**: Создайте запрос, который показывает, сколько заказов было сделано каждым покупателем со сгруппированными по рейтингу результатами (без пропусков).
--SELECT
--*
--,DENSE_RANK() OVER (ORDER BY soq.order_quantity DESC) AS [DENSE_RANK]
--FROM
--(SELECT
--b.buyer_name
--,COUNT(o.order_number) AS order_quantity
--FROM study.orders o 
--JOIN study.buyers b ON b.buyer_id = o.buyer_id
--GROUP BY b.buyer_name) AS soq

--   - **Задание 3**: Выведите покупателей и вставьте плотный ранг для каждого покупателя сделавшего заказ, на основе их возраста.
--SELECT 
--b.buyer_name
--,b.birthday
--,DENSE_RANK() OVER (ORDER BY b.birthday ASC)  AS [dense_rank]
--FROM study.orders o
-- JOIN study.buyers b ON b.buyer_id = o.buyer_id
--GROUP BY b.buyer_name, b.birthday
 
--### 4. **NTILE(n)**
--   - **Задание 1**: Разделите покупателей на 4 группы по количеству заказов и покажите, какие группы включают в себя каких покупателей.
--SELECT
--    b.buyer_name,
--    COUNT(o.order_number) AS order_quantity,
--    NTILE(4) OVER (ORDER BY COUNT(o.order_number) DESC) AS ntile_group
--FROM study.buyers b
--LEFT JOIN study.orders o ON o.buyer_id = b.buyer_id
--GROUP BY b.buyer_name

--   - **Задание 2**: Разбейте все изделия на 3 группы по цене и выведите эти группы.
--SELECT
--*
--,NTILE(3) OVER (ORDER BY pr.price DESC) AS [ntile]
--FROM study.products pr

--   - **Задание 3**: Проведите анализ общего объема продаж и отделите их на 5 уровней по величине заказа.
--SELECT 
--o.order_id
--,o.order_number
--,o.order_summa
--,NTILE(5) OVER (ORDER BY o.order_summa DESC) AS [nitle]
--,pr.[price]
--,pr.product_name
--,pr.[description]
--FROM study.orders o
--JOIN study.orders_productsNN nn ON o.order_id = nn.order_id
--RIGHT JOIN study.products pr ON pr.product_id = nn.product_id

--### 5. **SUM()**
--   - **Задание 1**: Напишите запрос для вычисления общей суммы заказов для каждого покупателя.
--SELECT 
--b.buyer_name
--,SUM(o.order_summa) OVER (PARTITION BY b.buyer_id) AS [sum_All_orders]
--FROM study.buyers b
--JOIN study.orders o ON o.buyer_id = b.buyer_id
--ORDER BY b.buyer_name DESC

--   - **Задание 2**: Выведите общую сумму всех заказов для каждого типа продукта.
--WITH RankedOrders AS (
--    SELECT 
--        o.order_id,
--        pr.type_id,
--        o.order_summa,
--        ROW_NUMBER() OVER (PARTITION BY o.order_id ORDER BY o.order_summa) AS rn
--    FROM study.orders o
--    JOIN study.orders_productsNN nn ON nn.order_id = o.order_id
--    JOIN study.products pr ON pr.product_id = nn.product_id
--)

--SELECT DISTINCT
--    r.type_id,
--    SUM(order_summa) OVER (PARTITION BY r.type_id ) AS total_order_sum
--FROM RankedOrders r
--WHERE rn = 1 
--ORDER BY type_id;

--   - **Задание 3**: Создайте отчет, который показывает сумму продаж для каждого месяца.
--SELECT
--o.order_date
--,SUM(o.order_summa) OVER (PARTITION BY MONTH(o.order_date))
--FROM study.orders o

--SELECT
--MONTH(o.order_date) AS month_date
--,SUM(o.order_summa)
--FROM study.orders o
--GROUP BY  MONTH(o.order_date)
--ORDER BY month_date


--### 6. **AVG()**
--   - **Задание 1**: Вычислите среднее значение стоимости товаров для каждого типа продукции.
--SELECT
--pr.product_name
--,AVG(pr.price) OVER (PARTITION BY pr.type_id) AS [avg_price]
--,pr.type_id
--FROM study.products pr

--SELECT
--AVG(pr.price)
--,pr.type_id
--FROM study.products pr
--GROUP BY pr.type_id
--   - **Задание 2**: Получите среднюю сумму заказов по каждому покупателю.
--SELECT
--b.buyer_name
--,AVG(o.order_summa) OVER(PARTITION BY b.buyer_id ) AS [avg_order_summa]
--FROM study.buyers b
--JOIN study.orders o ON o.buyer_id = b.buyer_id
--ORDER BY [avg_order_summa]

--SELECT
--b.buyer_name
--,AVG(o.order_summa) AS [avg_order_summa]
--FROM study.buyers b
--JOIN study.orders o ON o.buyer_id = b.buyer_id
--GROUP BY b.buyer_name
--ORDER BY avg_order_summa
--   - **Задание 3**: Определите средний возраст покупателей и выведите его вместе с именами.
--SELECT
--*
--,AVG(DATEDIFF(YEAR,b.birthday,GETDATE())) OVER(PARTITION BY b.buyer_id) AS [avg_year]
--FROM study.buyers b
--ORDER BY [avg_year] 

--SELECT
--AVG(DATEDIFF(YEAR,b.birthday,GETDATE())) AS [avg_year]
--,b.birthday
--,b.buyer_id
--,b.buyer_name
--FROM study.buyers b
--GROUP BY b.birthday, b.buyer_id, b.buyer_name

--ORDER BY [avg_year]
--### 7. **COUNT()**
--   - **Задание 1**: Подсчитайте количество заказов для каждого покупателя.
--SELECT
--* 
--,COUNT(o.order_number) OVER(PARTITION BY b.buyer_name) AS [buyers_order_quantiy]
--FROM study.buyers b
--JOIN study.orders o ON o.buyer_id = b.buyer_id

--   - **Задание 2**: Выведите количество различных типов продуктов в базе данных.
--SELECT
--*
--,COUNT(pr.product_name) OVER(PARTITION BY pr.type_id) AS [count_product_name]
--FROM study.products pr

--   - **Задание 3**: Определите, сколько услуг было продано на основании заказов.
--SELECT
--*
--,COUNT(o.order_number) OVER(PARTITION BY pr.type_id) AS [count_order_number]
--FROM study.orders o
--JOIN study.orders_productsNN nn ON nn.order_id = o.order_id
--JOIN study.products pr ON pr.product_id = nn.product_id
--WHERE pr.type_id = 2
 
--### 8. **MIN() и MAX()**
--   - **Задание 1**: Найдите минимальную и максимальную цену среди всех товаров.
--SELECT 
--*
--,MAX(pr.price) OVER() AS [max_price]
--,MIN(pr.price) OVER() AS [min_price]
--FROM study.products pr

--   - **Задание 2**: Выведите дату самого раннего и самого позднего заказа в базе.
--SELECT
--*
--,MAX(o.order_date) OVER() AS [max_order_date]
--,MIN(o.order_date) OVER() AS [min_order_date]
--FROM study.orders o
--   - **Задание 3**: Определите, какой покупатель имеет наименьшую и наибольшую общую сумму заказов.
   --   WITH buyer_orders_sum AS
	  --(SELECT 
	  -- b.buyer_id
	  -- ,b.birthday
	  -- ,b.buyer_name	 
	  -- ,SUM(o.order_summa) OVER(PARTITION BY b.buyer_id) AS [buyer_total_summa]
	  -- FROM study.buyers b
	  -- JOIN study.orders o ON o.buyer_id = b.buyer_id)
	   
	  --SELECT
	  --MIN(bos.buyer_total_summa)   [min_summa]
	  --,MAX(bos.buyer_total_summa)  [max_summa]
	  --FROM buyer_orders_sum bos
	  
--### 9. **LAG()**
--   - **Задание 1**: Используя `LAG()`, покажите, как сумма заказов каждого покупателя изменяется со временем.

--SELECT
--*
--,LAG(o.order_summa, 0,0) OVER(PARTITION BY b.buyer_id ORDER BY o.order_date) AS [lag_buyer_order_history]
--FROM study.orders o
--JOIN study.buyers b ON b.buyer_id = o.buyer_id

--   - **Задание 2**: Выведите информацию о товарах и их ценах, а также цену предыдущего товара в списке для сравнения.
--   - **Задание 3**: Сравните количество заказов текущего месяца с предыдущим месяцем, используя функцию `LAG()`.

--### 10. **LEAD()**
--   - **Задание 1**: Выведите список покупателей с текущими и следующими суммами их заказов.
--SELECT
--*
--,LEAD(o.order_summa) OVER(PARTITION BY b.buyer_id ORDER BY o.order_date) AS [next_order_summa]
--FROM study.buyers b
--JOIN study.orders o ON o.buyer_id = b.buyer_id

--   - **Задание 2**: Сравните текущую цену товара с ценой следующего товара в списке.
--SELECT
--*
--,LEAD(pr.price) OVER(ORDER BY pr.product_name) AS [next_product_price]
--FROM study.products pr

--   - **Задание 3**: Определите, какой покупатель сделал наибольший заказ в текущем месяце, и выведите информацию о следующем заказе этого покупателя.
--SELECT
--b.buyer_id
--,b.buyer_name
--,o.order_id
--,o.order_date
--,o.order_number
--,o.order_summa
----,MAX(o.order_summa) OVER(PARTITION BY b.buyer_id) AS [max_order]
--,LEAD(o.order_summa) OVER(PARTITION BY b.buyer_id ORDER BY o.order_date)	AS [next_order_summa]
--FROM study.buyers b
--JOIN study.orders o	 ON o.buyer_id = b.buyer_id
--WHERE o.order_date BETWEEN '2020.05.01' AND '2020.05.31'
--GROUP BY b.buyer_id
--,b.buyer_name
--,o.order_id
--,o.order_date
--,o.order_number
--,o.order_summa
--HAVING o.order_summa = MAX(o.order_summa)


--### 11. **FIRST_VALUE()**
--   - **Задание 1**: Используйте `FIRST_VALUE()` для получения самой ранней даты заказа для каждого покупателя.
--SELECT
--*
--,FIRST_VALUE(o.order_date) OVER(PARTITION BY b.buyer_id ORDER BY o.order_date)
--FROM study.buyers b
--JOIN study.orders o ON o.buyer_id = b.buyer_id
--   - **Задание 2**: Выведите первую цену этого товара из таблицы `products` для каждого типа продукта.

--   - **Задание 3**: Определите, какой продукт был первым в каждом заказе, и выведите его название и цену.

--### 12. **LAST_VALUE()**
--   - **Задание 1**: Используйте `LAST_VALUE()` для определения последней цены каждого товара на складе.
--   - **Задание 2**: Создайте отчет о последних заказах покупателей, выводя последнее значение суммы заказа.
--   - **Задание 3**: Выведите последнюю дату покупки для каждого покупателя, используя `LAST_VALUE()`.

--### 13. **CUME_DIST()**
--   - **Задание 1**: Рассчитайте кумулятивное распределение для сумм заказов, чтобы понять, какой процент покупателей совершил заказы до определенного порога.
--   - **Задание 2**: Определите кумулятивное распределение всех продуктов по ценам и выведите результаты.
--   - **Задание 3**: Используя `CUME_DIST()`, узнайте, какой процент заказов был выполнен с определенной суммой.
--### 14. **PERCENT_RANK()**
--   - **Задание 1**: Примените `PERCENT_RANK()` к общей сумме заказов покупателей для ранжирования их по достиженным суммам.
--   - **Задание 2**: Определите процентный ранг для цен товаров в категории "Физический" и выведите результаты.
--   - **Задание 3**: Вычислите процентный ранг каждого заказа по сравнению с другими в месяце.
--### 15. **PERCENTILE_CONT()**
--   - **Задание 1**: Рассчитайте 50-й процентиль (медиану) цен всех товаров и выведите результат.
--   - **Задание 2**: Определите, какая сумма заказов является 75-м процентилем среди всех заказов, и отобразите ее значение.
--   - **Задание 3**: Выведите сумму заказов по месяцам и определите 90-й процентиль по значению.
--### 16. **PERCENTILE_DISC()**
--   - **Задание 1**: Используйте `PERCENTILE_DISC()` для определения процентиля цен в категории товаров каждый тип продукта.
--   - **Задание 2**: Вычислите 25-й и 75-й процентиль по сумму заказов для анализа разброса данных.
--   - **Задание 3**: Проведите анализ, чтобы определить, какой процент заказов составляют лучшие 10% по прибыли.

-- 20 задач со средним уровнем сложности для работы с хранимыми процедурами, 
-- оконные функции, агрегатные функции и работу с датами:

--1. **Добавить нового покупателя и вернуть текущую дату**: Создайте процедуру для добавления нового покупателя в таблицу `buyers`, которая возвращает дату добавления.
--SELECT
--*
--FROM study.buyers b;

--GO

--CREATE PROCEDURE insert_buyer_name
--(
--    @buyer_id INT,
--    @buyer_name VARCHAR(100),
--    @birthday DATE
--)
--AS 
--BEGIN
--    INSERT INTO study.buyers (buyer_id, buyer_name, birthday)
--    VALUES (@buyer_id, @buyer_name, @birthday);

--    SELECT GETDATE() AS insert_buyer_date;
--END;

--GO

--EXEC study.insert_buyer_name 111, 'James B.D', '1981-04-05'; 

--GO

--SELECT
--*
--FROM study.buyers b;

--2. **Обновить информацию о покупателе James B.D **: Создайте процедуру, которая обновляет имя покупателя и вычисляет его возраст на основе даты рождения, возвращая возраст покупателя.

--EXEC study.update_buyers_name 'Jamess B.D', 'rrrrr' ;

--SELECT
--*
--FROM study.buyers;

--GO
  
--CREATE PROCEDURE [study].[update_buyers_name]
--(@buyer_name NVARCHAR(200)
-- ,@new_buyer_name NVARCHAR(200)) 
--AS
--BEGIN
--  UPDATE study.buyers 
--  SET buyer_name = @new_buyer_name
--  WHERE buyer_name = @buyer_name
--  SELECT 
--  DATEDIFF(YEAR, b.birthday, GETDATE()) AS buyers_age
--  FROM study.buyers b
--  WHERE buyer_name = @new_buyer_name
--END

--3. **Удалить покупателя и связанные заказы**: Создайте процедуру для удаления покупателя по `buyer_id`= 111 и всех его заказов из таблицы `orders`.
--select
--*
--from study.buyers b
--LEFT JOIN study.orders o ON o.buyer_id = b.buyer_id;

--GO

--INSERT INTO  study.orders
--VALUES
--(555, 111, 212,GETDATE(),0.00)

--ALTER PROCEDURE study.delete_order_on_buyer_id(@buyer_id INT)
--AS
--BEGIN
--DELETE FROM study.orders
--WHERE buyer_id = @buyer_id

--DELETE FROM study.buyers
--WHERE buyer_id = @buyer_id

--select
--*
--from study.buyers b
--LEFT JOIN study.orders o ON o.buyer_id = b.buyer_id;
--END;

--EXEC study.delete_order_on_buyer_id 111;


--4. **Добавить новый заказ и обновить общую сумму заказов покупателя**: Создайте процедуру для добавления нового заказа и обновления общей суммы всех заказов покупателя с использованием оконной функции.

--5. **Обновить информацию о заказе и вернуть количество заказов за текущий месяц**: Создайте процедуру для обновления данных заказа и подсчета количества заказов за текущий месяц.

--6. **Удалить заказ и вернуть новые средние продажи**: Создайте процедуру для удаления заказа и вычисления новой средней суммы заказа с использованием агрегатной функции.

--7. **Добавить новый тип продукции и вернуть его ошибки**: Создайте процедуру для добавления нового типа продукции и проверки, что имя типа уникально, возвращая ошибку, если оно повторяется.

--8. **Обновить тип продукции и вернуть список всех типов с общим количеством продуктов**: Создайте процедуру для обновления типа продукции и вывода списка всех типов продукции с количеством продуктов для каждого типа.

--9. **Удалить тип продукции и переназначить эти продукты на другой тип**: Создайте процедуру для удаления типа продукции и переназначения продуктов на указанный `type_id`.

--10. **Добавить новый продукт и рассчитать среднюю цену всех продуктов этого типа**: Создайте процедуру с добавлением нового продукта и расчётом средней цены всех продуктов данного `type_id`.

--11. **Обновить информацию о продукте и вернуть рейтинг продаж**: Создайте процедуру, которая обновляет информацию о продукте и возвращает его место в рейтинге по продажам с использованием оконных функций.

--12. **Удалить продукт и вычислить общую потерю продаж**: Создайте процедуру для удаления продукта и вычисления, на сколько уменьшилась общая сумма всех продаж.

--13. **Добавить продукт в заказ и обновить сумму заказа**: Создайте процедуру для добавления продукта в заказ и обновления суммы заказа, включая новый продукт.

--14. **Найти заказы покупателя за последний год**: Создайте процедуру для поиска и вывода всех заказов, сделанных конкретным покупателем за последний год.

--15. **Найти все продукты в заказе и отсортировать по цене**: Создайте процедуру для вывода всех продуктов в определенном заказе, отсортированных по убыванию цены.

--16. **Рассчитать общую стоимость заказов за неделю**: Создайте процедуру для расчета общей стоимости всех заказов, сделанных за последнюю неделю.

--17. **Сделать выборку покупателей с заказами выше средней суммы**: Создайте процедуру для выборки всех покупателей, у которых хотя бы один заказ превышает среднюю сумму всех заказов.

--18. **Найти популярные типы продукции за последние три месяца**: Создайте процедуру для определения типов продукции, наиболее часто заказанных за последние три месяца.

--19. **Суммировать продажи по месяцам для каждого типа продукции**: Создайте процедуру, которая суммирует продажи по каждому месяцу и типу продукции и возвращает результаты за последний год.

--20. **Генерация ежемесячного отчета по продажам и отправка уведомления**: Создайте процедуру для создания отчета о продажах за указанный месяц и год и отправки уведомления, если продажи ниже заданного порога. 

--Эти задачи призваны помочь вам развивать навыки работы с SQL и хранимыми процедурами, включая использование более сложной логики и требуемых функций.



