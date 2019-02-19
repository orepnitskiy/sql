use test
set names utf8;

-- 1. Выбрать все товары (все поля)
select * from product

-- 2. Выбрать названия всех автоматизированных складов
select name from store where store.is_automated = 1;

-- 3. Посчитать общую сумму в деньгах всех продаж
select SUM(total) from sale;

-- 4. Получить уникальные store_id всех складов, с которых была хоть одна продажа
SELECT DISTINCT store_id FROM sale WHERE quantity>0;

-- 5. Получить уникальные store_id всех складов, с которых не было ни одной продажи
select store_id from store where store_id not in(select store_id from sale);

-- 6. Получить для каждого товара название и среднюю стоимость единицы товара avg(total/quantity), если товар не продавался, он не попадает в отчет.
select product.name, avg(total/quantity) from sale, product where sale.product_id = product.product_id  group by sale.product_id

-- 7. Получить названия всех продуктов, которые продавались только с единственного склада
select name from (select product.name, count(distinct store_id) as sc from sale join product on sale.product_id = product.product_id group by sale.product_id having sc = 1) as T;
-- 8. Получить названия всех складов, с которых продавался только один продукт
select name from (select store.name, count(distinct(sale.product_id)) as pc from sale join store on sale.store_id = store.store_id group by sale.store_id having pc = 1) as T;

-- 9. Выберите все ряды (все поля) из продаж, в которых сумма продажи (total) максимальна (равна максимальной из всех встречающихся)
select * from sale where total in (select max(total) from sale);

-- 10. Выведите дату самых максимальных продаж, если таких дат несколько, то самую раннюю из них
select date from sale order by total limit 1;
