with 

source as (

    select * from {{ source('raw', 'sales_salesorderdetail') }}

),

sales_salesorderdetail as (

    select
        {{ dbt_utils.generate_surrogate_key(['salesorderid','salesorderdetailid','productid'])}} as id,
        salesorderid as pedido_id,
        salesorderdetailid as item_id,
        productid,
        orderqty as quantidade,
        specialofferid,
        unitprice as vlr_unitario,
        unitpricediscount as vlr_desconto

    from source

)

select * from sales_salesorderdetail