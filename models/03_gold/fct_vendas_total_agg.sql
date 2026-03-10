with
    pedido as 
    (
        select *
        from {{ ref('silver__pedido') }}
    )

    , localidade as 
    (
        select *
        from {{ ref('silver__localidade') }}
    )

    , joined as (
        select
            pedido.id
            , year(pedido.data_pedido) as ano
            , month(pedido.data_pedido) as mes 
            , pedido.pedido_id
            , pedido.item_id
            , pedido.data_pedido
            , pedido.status
            , pedido.customerid
            , pedido.id_ender_cobranca
            , pedido.cardtype
            , pedido.productid
            , pedido.vlr_unitario
            , pedido.quantidade
            , pedido.vlr_desconto
            , pedido.vlr_unitario * pedido.quantidade as vlr_total_item
            , pedido.vlr_unitario * (1 - pedido.vlr_desconto) * pedido.quantidade as vlr_total_com_desconto
            , cast(
                (pedido.vlr_total_frete / count(*) over (partition by pedido.pedido_id))
            as numeric(18,2)) as frete_alocado
            , case
                when pedido.vlr_desconto > 0 then true
                else false
            end as flg_desconto
            , localidade.dsc_cidade
            , localidade.dsc_estado
            , localidade.dsc_pais
        from pedido
        inner join localidade
        on pedido.id_ender_cobranca = localidade.addressid
    )

select * from joined