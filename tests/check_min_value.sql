{{ config(store_failures=true) }}

with orders as (
    select *
    from {{ source('src','orders') }}
)

select order_id,
       sum(total_price) as order_total
from orders
group by 1
having order_total <= 1000