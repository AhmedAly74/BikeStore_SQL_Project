-- 1) Most expensive bike
SELECT TOP 1 product_name, MAX(revenue / NULLIF(total_units, 0)) AS unit_price
FROM BikesStores
GROUP BY product_name
ORDER BY unit_price DESC;

-- 2) Total customers 
SELECT COUNT(DISTINCT customers) AS total_customers FROM BikesStores;

-- 3) Total stores
SELECT COUNT(DISTINCT store_name) AS total_stores FROM BikesStores;

-- 4) Total price per order
SELECT order_id, SUM(revenue) AS total_price
FROM BikesStores
GROUP BY order_id;

-- 5) Sales per store
SELECT store_name, SUM(revenue) AS store_revenue
FROM BikesStores
GROUP BY store_name
ORDER BY store_revenue DESC;

-- 6) Most sold category
SELECT TOP 1 category_name, SUM(total_units) AS total_sold
FROM BikesStores
GROUP BY category_name
ORDER BY total_sold DESC;

-- 7) Most rejected category 
SELECT TOP 1 category_name, COUNT(*) AS rejected_orders
FROM BikesStores
WHERE total_units = 0
GROUP BY category_name
ORDER BY rejected_orders DESC;

-- 8) Least sold bike
SELECT TOP 1 product_name, SUM(total_units) AS units_sold
FROM BikesStores
GROUP BY product_name
ORDER BY units_sold ASC;

-- 9) Full name of customer 259
SELECT DISTINCT customers FROM BikesStores
WHERE customers LIKE '%259%';

-- 10) What did customer 259 buy and when?
SELECT order_id, product_name, order_date, revenue, total_units
FROM BikesStores
WHERE customers LIKE '%259%';

-- 11) Staff who processed customer 259’s order
SELECT DISTINCT sales_rep, store_name
FROM BikesStores
WHERE customers LIKE '%259%';

-- 12) Number of staff and possible lead staff
SELECT COUNT(DISTINCT sales_rep) AS total_staff FROM BikesStores;
-- Possible lead staff (الأكثر مبيعات)
SELECT TOP 1 sales_rep, SUM(revenue) AS total_sales
FROM BikesStores
GROUP BY sales_rep
ORDER BY total_sales DESC;

-- 13) Most liked brand (بناءً على المبيعات)
SELECT TOP 1 brand_name, SUM(total_units) AS total_units_sold
FROM BikesStores
GROUP BY brand_name
ORDER BY total_units_sold DESC;

-- 14) Number of categories + least liked
SELECT COUNT(DISTINCT category_name) AS category_count FROM BikesStores;

SELECT TOP 1 category_name, SUM(total_units) AS total_sold
FROM BikesStores
GROUP BY category_name
ORDER BY total_sold ASC;

-- 15) Store with most products of the most liked brand
SELECT TOP 1 store_name, SUM(total_units) AS total_units_sold
FROM BikesStores
WHERE brand_name = (
    SELECT TOP 1 brand_name
    FROM bikestore_sales
    GROUP BY brand_name
    ORDER BY SUM(total_units) DESC
)
GROUP BY store_name
ORDER BY total_units_sold DESC;


-- 16) Top state by sales
SELECT TOP 1 state, SUM(revenue) AS total_sales
FROM BikesStores
GROUP BY state
ORDER BY total_sales DESC;

-- 17) Discounted price of product_id 259 (مفيش product_id لكن ممكن نفترض اسمه أو تضيف ID)
SELECT TOP 1 product_name, revenue / total_units AS unit_price
FROM BikesStores
WHERE product_name LIKE '%259%';

-- 18) Details of product number 44
SELECT *
FROM BikesStores
WHERE product_name LIKE '%44%';

-- 19) Zip code of CA (مفيش zip code في الداتا – بس نعرض المدن التابعة لـ CA)
SELECT DISTINCT city
FROM BikesStores
WHERE state = 'CA';

-- 20) Number of states
SELECT COUNT(DISTINCT state) AS total_states FROM BikesStores;

-- 21) Bikes sold under Children category in last 8 months
SELECT SUM(total_units) AS children_sold
FROM BikesStores
WHERE category_name = 'Children'
  AND order_date >= DATEADD(MONTH, -8, GETDATE());

-- 22) Shipped date for order from customer 523 (مفيش shipped_date فهنعرض order_date فقط)
SELECT DISTINCT order_date
FROM BikesStores
WHERE customers LIKE '%523%';

-- 23) Pending orders 
SELECT COUNT(*) AS pending_orders
FROM BikesStores
WHERE total_units = 0;

-- 24) Category and brand of “Electra white water 3i - 2018”
SELECT DISTINCT product_name, category_name, brand_name
FROM BikesStores
WHERE product_name LIKE '%Electra white water 3i%';
