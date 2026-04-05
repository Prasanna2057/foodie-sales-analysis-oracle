UPDATE foodie_raw
SET
    order_date_clean =
        CASE
            WHEN order_date LIKE '%/%' THEN
                TO_DATE(order_date, 'DD/MM/YYYY')
            ELSE
                TO_DATE(order_date, 'DD-MM-YYYY')
        END;

SELECT
    *
FROM
    foodie_raw;

--Data validation and cleaning
SELECT
    SUM(
        CASE
            WHEN state IS NULL THEN
                1
            ELSE
                0
        END
    ) AS null_state,
    SUM(
        CASE
            WHEN city IS NULL THEN
                1
            ELSE
                0
        END
    ) AS null_city,
    SUM(
        CASE
            WHEN restaurant_name IS NULL THEN
                1
            ELSE
                0
        END
    ) AS null_restaurant,
    SUM(
        CASE
            WHEN location IS NULL THEN
                1
            ELSE
                0
        END
    ) AS null_location,
    SUM(
        CASE
            WHEN category IS NULL THEN
                1
            ELSE
                0
        END
    ) AS null_category,
    SUM(
        CASE
            WHEN dish_name IS NULL THEN
                1
            ELSE
                0
        END
    ) AS null_dish,
    SUM(
        CASE
            WHEN price_npr IS NULL THEN
                1
            ELSE
                0
        END
    ) AS null_price,
    SUM(
        CASE
            WHEN rating IS NULL THEN
                1
            ELSE
                0
        END
    ) AS null_rating,
    SUM(
        CASE
            WHEN rating_count IS NULL THEN
                1
            ELSE
                0
        END
    ) AS null_ratingcount,
    SUM(
        CASE
            WHEN order_date IS NULL THEN
                1
            ELSE
                0
        END
    ) AS null_orderdate
FROM
    foodie_raw;

--NVL Function for null values
SELECT
    nvl(state, 'Unknown')           AS state,
    nvl(city, 'Unknown')            AS city,
    nvl(restaurant_name, 'Unknown') AS restaurant_name,
    nvl(location, 'Unknown')        AS location,
    nvl(category, 'Unknown')        AS category,
    nvl(dish_name, 'Unknown')       AS dish_name,
    nvl(price_npr, 0)               AS price_npr,
    nvl(rating, 0)                  AS rating,
    nvl(rating_count, 0)            AS rating_count,
    order_date
FROM
    foodie_raw;

--Blank or Empty Strings
SELECT
    *
FROM
    foodie_raw
WHERE
    state = ''
    OR city = ''
    OR restaurant_name = ''
    OR location = ''
    OR category = ''
    OR dish_name = ''
    OR order_date = '';

--Duplicate Data
SELECT
    state,
    city,
    restaurant_name,
    location,
    category,
    dish_name,
    price_npr,
    rating,
    rating_count,
    order_date,
    COUNT(*) AS count
FROM
    foodie_raw
GROUP BY
    state,
    city,
    restaurant_name,
    location,
    category,
    dish_name,
    price_npr,
    rating,
    rating_count,
    order_date
HAVING
    COUNT(*) > 1;

-- Delete duplicate data
DELETE FROM foodie_raw
WHERE
    ROWID IN (
        SELECT
            rid
        FROM
            (
                SELECT
                    ROWID AS rid, ROW_NUMBER()
                                  OVER(PARTITION BY state, city, restaurant_name, order_date, location,
                                                    category, rating, rating_count, dish_name, price_npr
                                       ORDER BY
                                           ROWID
                    )     AS rn
                FROM
                    foodie_raw
            )
        WHERE
            rn > 1
    );
