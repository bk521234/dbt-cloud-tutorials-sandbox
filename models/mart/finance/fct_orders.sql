with customers as (

     select * from {{ ref('stg_jaffle_shop__customers') }}

),

orders as ( 

    select * from {{ ref('stg_jaffle_shop__orders') }}

),
payments as ( 
    select * from {{ ref('stg_stripe__payments') }}
), final as (

    select
        o.order_id,
        c.customer_id,
        max(o.order_date) as order_date,
        sum(p.amount) as amount


    from orders o
        left join customers c using (customer_id)
        left join payments p using (order_id)
group by 1, 2
)

select * from final
