-- Query 1
SELECT
    order_id,
    customer_id,
    order_date,
    ROW_NUMBER() OVER (
        PARTITION BY customer_id
        ORDER BY order_date, order_id
    ) AS order_number
FROM northwind_orders
ORDER BY customer_id, order_date, order_id;


-- Query 2
SELECT
    order_id,
    product_id,
    quantity,
    unit_price,
    ROW_NUMBER() OVER (
        PARTITION BY order_id
        ORDER BY product_id
    ) AS item_number
FROM northwind_order_details
ORDER BY order_id, item_number;


-- Query 3
SELECT
    order_id,
    customer_id,
    freight,
    RANK() OVER (
        ORDER BY freight DESC
    ) AS freight_rank
FROM northwind_orders
ORDER BY freight_rank, order_id;


-- Query 4
SELECT
    order_id,
    customer_id,
    freight,
    RANK() OVER (
        ORDER BY freight DESC
    ) AS rank_position,
    DENSE_RANK() OVER (
        ORDER BY freight DESC
    ) AS dense_rank_position
FROM northwind_orders
ORDER BY freight DESC, order_id;


-- Query 5
WITH order_totals AS (
    SELECT
        o.order_id,
        o.customer_id,
        o.order_date,
        SUM(
            d.unit_price * d.quantity * (1 - d.discount)
        ) AS order_value
    FROM northwind_orders o
    JOIN northwind_order_details d
        ON o.order_id = d.order_id
    GROUP BY
        o.order_id,
        o.customer_id,
        o.order_date
)

SELECT
    order_id,
    customer_id,
    order_date,
    ROUND(order_value, 2) AS order_value,
    RANK() OVER (
        ORDER BY order_value DESC
    ) AS value_rank
FROM order_totals
ORDER BY value_rank, order_id;


-- Query 6
WITH order_totals AS (
    SELECT
        o.order_id,
        o.customer_id,
        o.order_date,
        SUM(
            d.unit_price * d.quantity * (1 - d.discount)
        ) AS order_value
    FROM northwind_orders o
    JOIN northwind_order_details d
        ON o.order_id = d.order_id
    GROUP BY
        o.order_id,
        o.customer_id,
        o.order_date
)

SELECT
    order_id,
    customer_id,
    order_date,
    ROUND(order_value, 2) AS order_value,
    DENSE_RANK() OVER (
        ORDER BY order_value DESC
    ) AS value_dense_rank
FROM order_totals
ORDER BY value_dense_rank, order_id;


-- Query 7
SELECT
    order_id,
    customer_id,
    order_date,
    LAG(order_date) OVER (
        PARTITION BY customer_id
        ORDER BY order_date, order_id
    ) AS previous_order_date
FROM northwind_orders
ORDER BY customer_id, order_date, order_id;


-- Query 8
WITH customer_orders AS (
    SELECT
        order_id,
        customer_id,
        order_date,
        LAG(order_date) OVER (
            PARTITION BY customer_id
            ORDER BY order_date, order_id
        ) AS previous_order_date
    FROM northwind_orders
)

SELECT
    order_id,
    customer_id,
    order_date,
    previous_order_date,
    ROUND(
        julianday(order_date) -
        julianday(previous_order_date),
        1
    ) AS days_since_previous_order
FROM customer_orders
ORDER BY customer_id, order_date, order_id;


-- Query 9
WITH customer_orders AS (
    SELECT
        order_id,
        customer_id,
        order_date,
        freight,
        LAG(freight) OVER (
            PARTITION BY customer_id
            ORDER BY order_date, order_id
        ) AS previous_freight
    FROM northwind_orders
)

SELECT
    order_id,
    customer_id,
    order_date,
    ROUND(freight, 2) AS current_freight,
    ROUND(previous_freight, 2) AS previous_freight,
    ROUND(
        freight - previous_freight,
        2
    ) AS freight_change
FROM customer_orders
ORDER BY customer_id, order_date, order_id;


-- Query 10
WITH monthly_sales AS (
    SELECT
        strftime('%Y-%m', o.order_date) AS order_month,
        SUM(
            d.unit_price * d.quantity * (1 - d.discount)
        ) AS total_sales
    FROM northwind_orders o
    JOIN northwind_order_details d
        ON o.order_id = d.order_id
    GROUP BY order_month
)

SELECT
    order_month,
    ROUND(total_sales, 2) AS total_sales,
    ROUND(
        LAG(total_sales) OVER (
            ORDER BY order_month
        ),
        2
    ) AS previous_month_sales,
    ROUND(
        total_sales -
        LAG(total_sales) OVER (
            ORDER BY order_month
        ),
        2
    ) AS change_from_previous_month
FROM monthly_sales
ORDER BY order_month;


-- Query 11
WITH order_totals AS (
    SELECT
        o.order_id,
        o.customer_id,
        o.order_date,
        SUM(
            d.unit_price * d.quantity * (1 - d.discount)
        ) AS order_value
    FROM northwind_orders o
    JOIN northwind_order_details d
        ON o.order_id = d.order_id
    GROUP BY
        o.order_id,
        o.customer_id,
        o.order_date
)

SELECT
    order_id,
    customer_id,
    order_date,
    ROUND(order_value, 2) AS order_value,
    ROW_NUMBER() OVER (
        PARTITION BY customer_id
        ORDER BY order_value DESC, order_id
    ) AS customer_order_rank
FROM order_totals
ORDER BY customer_id, customer_order_rank;


-- Query 12
WITH customer_sales AS (
    SELECT
        o.customer_id,
        SUM(
            d.unit_price * d.quantity * (1 - d.discount)
        ) AS total_sales
    FROM northwind_orders o
    JOIN northwind_order_details d
        ON o.order_id = d.order_id
    GROUP BY o.customer_id
)

SELECT
    customer_id,
    ROUND(total_sales, 2) AS total_sales,
    RANK() OVER (
        ORDER BY total_sales DESC
    ) AS customer_rank
FROM customer_sales
ORDER BY customer_rank, customer_id;