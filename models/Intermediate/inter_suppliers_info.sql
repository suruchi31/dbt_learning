{{ config(materialized='incremental', unique_key='supplier_id' , alias='int_Suppliers') }}
{# if this (materialized='incremental') is not writen at the top then it will create a create statement, 
but in this case it will create insert statement #}
{#
Use alias word when you want to give the name of the table different from the current .sql file
#}

with suppliers as (
    select 
    supplier.supplier_id,
    supplier.supplier_name,
    supplier.supplier_address,
    supplier.phone_number,
    supplier.account_balance,
    supplier.updated_time

from {{ ref('stg_suppliers') }} supplier
{%if (is_incremental()) %}
where updated_time > (select max(updated_time) from {{this}} )
{% endif %}
)

select * from suppliers