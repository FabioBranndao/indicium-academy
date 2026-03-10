with 

source as (

    select * from {{ source('raw', 'sales_creditcard') }}

),

sales_creditcard as (

    select
        creditcardid,
        cardtype,
        cardnumber

    from source

)

select * from sales_creditcard