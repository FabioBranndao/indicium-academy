with 

source as (

    select * from {{ source('raw', 'sales_customer') }}

),

sales_customer as (

    select
        customerid,
        personid,
        territoryid

    from source
 
)

select * from sales_customer