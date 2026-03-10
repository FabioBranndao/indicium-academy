with 

source as (

    select * from {{ source('raw', 'sales_salesorderheadersalesreason') }}

),

sales_salesorderheadersalesreason as (

    select
        salesorderid,
        max(salesreasonid) as salesreasonid

    from source
    group by salesorderid

)

select * from sales_salesorderheadersalesreason