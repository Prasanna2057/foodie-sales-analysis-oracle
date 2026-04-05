--Data insertion
INSERT INTO dim_date (
    full_date,
    year_num,
    month_num,
    month_name,
    quarter_num,
    day_num,
    week_num
)
    SELECT DISTINCT
        order_date,
        EXTRACT(YEAR FROM order_date),
        EXTRACT(MONTH FROM order_date),
        rtrim(to_char(order_date, 'Month')),
        TO_NUMBER(to_char(order_date, 'Q')),
        EXTRACT(DAY FROM order_date),
        TO_NUMBER(to_char(order_date, 'IW'))
    FROM
        foodie_raw
    WHERE
        order_date IS NOT NULL;

INSERT INTO dim_location (
    state,
    city,
    location
)
    SELECT DISTINCT
        state,
        city,
        location
    FROM
        foodie_raw
    WHERE
        state IS NOT NULL
        AND city IS NOT NULL
        AND location IS NOT NULL;

INSERT INTO dim_restaurant ( restaurant_name )
    SELECT DISTINCT
        restaurant_name
    FROM
        foodie_raw
    WHERE
        restaurant_name IS NOT NULL;

INSERT INTO dim_category ( category )
    SELECT DISTINCT
        category
    FROM
        foodie_raw
    WHERE
        category IS NOT NULL;

INSERT INTO dim_dish ( dish_name )
    SELECT DISTINCT
        dish_name
    FROM
        foodie_raw
    WHERE
        dish_name IS NOT NULL;

INSERT INTO fact_foodie_orders (
    date_id,
    price_npr,
    rating,
    rating_count,
    location_id,
    restaurant_id,
    category_id,
    dish_id
)
    SELECT
        dd.date_id,
        f.price_npr,
        f.rating,
        f.rating_count,
        dl.location_id,
        dr.restaurant_id,
        dc.category_id,
        dsh.dish_id
    FROM
             foodie_raw f
        JOIN dim_date       dd ON dd.full_date = f.order_date
        JOIN dim_location   dl ON dl.state = f.state
                                AND dl.city = f.city
                                AND dl.location = f.location
        JOIN dim_restaurant dr ON dr.restaurant_name = f.restaurant_name
        JOIN dim_category   dc ON dc.category = f.category
        JOIN dim_dish       dsh ON dsh.dish_name = f.dish_name;

SELECT
    *
FROM
    fact_foodie_orders;

--Full Schema
SELECT
    *
FROM
         fact_foodie_orders f
    JOIN dim_date       d ON d.date_id = f.date_id
    JOIN dim_location   l ON l.location_id = f.location_id
    JOIN dim_restaurant r ON r.restaurant_id = f.restaurant_id
    JOIN dim_category   c ON c.category_id = f.category_id
    JOIN dim_dish       dsh ON dsh.dish_id = f.dish_id;

