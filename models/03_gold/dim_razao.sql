with 
    source as (
        select * from {{ ref('silver__razao') }}
    ),

    razao as (
        select
            salesorderid as pedido_id
            , dsc_razao
            , reasontype
            from source
    )

    select * from razao