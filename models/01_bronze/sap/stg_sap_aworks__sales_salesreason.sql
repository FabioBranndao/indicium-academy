with 

source as (

    select * from {{ source('raw', 'sales_salesreason') }}

),

sales_salesreason as (

    select
        salesreasonid,
        name as dsc_razao,
        reasontype

    from source

)

select * from sales_salesreason