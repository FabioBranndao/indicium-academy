with
    pedidos_items as (
        select *
        from {{ ref('stg_sap_aworks__sales_salesorderdetail') }}
    )

    , pedidos as (
        select *
        from {{ ref('stg_sap_aworks__sales_salesorderheader') }}
    )

    , cartoes as (
        select *
        from {{ ref('stg_sap_aworks__sales_creditcard') }}
    )

    , joined as (
        select
            pedidos.pedido_id,
            pedidos.data_pedido,
            pedidos.data_envio,
            pedidos.status,
            pedidos.customerid,
            pedidos.id_ender_cobranca,
            pedidos.id_ender_envio,
            pedidos.shipmethodid,
            pedidos.creditcardid,
            pedidos.currencyrateid,
            pedidos.vlr_subtotal,
            pedidos.vlr_total_imposto,
            pedidos.vlr_total_frete,
            pedidos.vlr_total,
            pedidos_items.id,
            pedidos_items.item_id,
            pedidos_items.productid,
            pedidos_items.quantidade,
            pedidos_items.specialofferid,
            pedidos_items.vlr_unitario,
            pedidos_items.vlr_desconto,
            cartoes.cardtype
        from pedidos_items
        inner join pedidos 
            on pedidos_items.pedido_id = pedidos.pedido_id
        inner join cartoes
            on pedidos.creditcardid =  cartoes.creditcardid
    )

select * from joined