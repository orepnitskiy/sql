use test
set names utf8;

-- 1. choose all products (all fields)
select * from product

-- 2. Choose names of all automated stocks
select name from store where store.is_automated = 1;

-- 3. Count total sum of all sales in money
select SUM(total) from sale;

-- 4. Get unique store_id of all stocks, where was at least one sale
SELECT DISTINCT store_id FROM sale WHERE quantity>0;

-- 5. Get unique store_id of all stocks, where were no sales
select store_id from store where store_id not in(select store_id from sale);

-- 6. Get name and average cost of every product
select product.name, avg(total/quantity) from sale, product where sale.product_id = product.product_id  group by sale.product_id

-- 7. Get names of all products, that were sold only from one stock
select name from (select product.name, count(distinct store_id) as sc from sale join product on sale.product_id = product.product_id group by sale.product_id having sc = 1) as T;
-- 8. Get names of all stocks, where was sold only one product
select name from (select store.name, count(distinct(sale.product_id)) as pc from sale join store on sale.store_id = store.store_id group by sale.store_id having pc = 1) as T;

-- 9. Choose all rows (all fields) from sales, where sum of sale (total) was max
select * from sale where total in (select max(total) from sale);

-- 10. Print date of maximal sales, if there's more than one date , then choose the latest date
select date from sale order by total limit 1;
