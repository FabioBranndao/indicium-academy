with 
    source as (
        select * from {{ ref('stg_sap_aworks__production_product') }}
    ),

    produto as (
        select
            productid,
            name as dsc_produto,
            productnumber,
            safetystocklevel
        from source
    )

    select * from produto