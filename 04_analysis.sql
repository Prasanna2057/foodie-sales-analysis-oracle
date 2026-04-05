--KPI's
--Total Orders
SELECT
    COUNT(*) AS total_orders
FROM
    fact_foodie_orders;

SELECT
    *
FROM
    fact_foodie_orders;

--Total Revenue (NPR Million)
SELECT
    round(sum(price_npr) / 1000000,
          2)
    || ' NPR Million' AS total_revenue
FROM
    fact_foodie_orders;

--Average Dish Price
SELECT
    round(
        avg(price_npr),
        2
    )
    || ' NPR' AS average_price
FROM
    fact_foodie_orders;

--Average Rating
SELECT
    round(
        avg(rating),
        2
    )
FROM
    fact_foodie_orders;

--Deep Dive Business Analysis

--Monthly trend
SELECT
    d.year_num,
    d.month_num,
    d.month_name,
    COUNT(*) AS total_orders
FROM
         fact_foodie_orders f
    JOIN dim_date d ON f.date_id = d.date_id
GROUP BY
    d.year_num,
    d.month_num,
    d.month_name
ORDER BY
    COUNT(*) DESC;

--Quaterly Trend
SELECT
    d.year_num,
    d.quarter_num,
    COUNT(*) AS total_orders
FROM
         fact_foodie_orders f
    JOIN dim_date d ON f.date_id = d.date_id
GROUP BY
    d.year_num,
    d.quarter_num
ORDER BY
    COUNT(*) DESC;

--Yearly Trend
SELECT
    d.year_num,
    COUNT(*) AS total_orders
FROM
         fact_foodie_orders f
    JOIN dim_date d ON f.date_id = d.date_id
GROUP BY
    d.year_num
ORDER BY
    COUNT(*) DESC;

--Orders by Day of week 
SELECT
    to_char(d.full_date, 'Day') AS day_name,
    COUNT(*)                    AS total_orders
FROM
         fact_foodie_orders f
    JOIN dim_date d ON f.date_id = d.date_id
GROUP BY
    to_char(d.full_date, 'Day'),
    to_char(d.full_date, 'D')
ORDER BY
    to_char(d.full_date, 'D');
    
--Top 10 cities by order volume
SELECT
    l.city,
    COUNT(*) AS total_orders
FROM
         fact_foodie_orders f
    JOIN dim_location l ON l.location_id = f.location_id
GROUP BY
    l.city
ORDER BY
    COUNT(*) DESC
FETCH FIRST 10 ROWS ONLY;

--Revenue contribution by states
SELECT
    l.state,
    SUM(f.price_npr) AS total_revenue
FROM
         fact_foodie_orders f
    JOIN dim_location l ON l.location_id = f.location_id
GROUP BY
    l.state
ORDER BY
    SUM(f.price_npr) DESC;

--Top 10 restaurants by orders
SELECT
    r.restaurant_name,
    SUM(f.price_npr) AS total_revenue
FROM
         fact_foodie_orders f
    JOIN dim_restaurant r ON r.restaurant_id = f.restaurant_id
GROUP BY
    r.restaurant_name
ORDER BY
    SUM(f.price_npr) DESC;

--Top Categories by order volume
SELECT
    c.category,
    COUNT(*) AS total_orders
FROM
         fact_foodie_orders f
    JOIN dim_category c ON c.category_id = f.category_id
GROUP BY
    c.category
ORDER BY
    COUNT(*) DESC;

--Most Ordered Dishes
SELECT
    d.dish_name,
    COUNT(*) AS total_orders
FROM
         fact_foodie_orders f
    JOIN dim_dish d ON d.dish_id = f.dish_id
GROUP BY
    d.dish_name
ORDER BY
    COUNT(*) DESC
FETCH FIRST 10 ROWS ONLY;

--Cuisine Performance (Orders + Avg Rating)
SELECT
    c.category,
    COUNT(*) AS total_orders,
    round(
        avg(f.rating),
        2
    )        AS avg_rating
FROM
         fact_foodie_orders f
    JOIN dim_category c ON f.category_id = c.category_id
GROUP BY
    c.category
ORDER BY
    COUNT(*) DESC;

--Customer Spending Insights
SELECT
    CASE
        WHEN price_npr < 100               THEN
            'under 100'
        WHEN price_npr BETWEEN 100 AND 199 THEN
            '100 - 199'
        WHEN price_npr BETWEEN 200 AND 299 THEN
            '200 - 299'
        WHEN price_npr BETWEEN 300 AND 499 THEN
            '300 - 499'
        ELSE
            '500+'
    END      AS price_range,
    COUNT(*) AS total_orders
FROM
    fact_foodie_orders
GROUP BY
    CASE
        WHEN price_npr < 100               THEN
            'under 100'
        WHEN price_npr BETWEEN 100 AND 199 THEN
            '100 - 199'
        WHEN price_npr BETWEEN 200 AND 299 THEN
            '200 - 299'
        WHEN price_npr BETWEEN 300 AND 499 THEN
            '300 - 499'
        ELSE
            '500+'
    END
ORDER BY
    total_orders DESC;

--Rating COunt Distribution (1-5)
SELECT
    rating,
    COUNT(*) AS rating_count
FROM
    fact_foodie_orders
GROUP BY
    rating
ORDER BY
    rating;