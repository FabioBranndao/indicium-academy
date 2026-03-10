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

    , produto as 
    (
        select *
        from {{ ref('dim_produtos') }}
    )

    , joined as (
        select
            pedido.pedido_id
            , pedido.data_pedido
            , localidade.dsc_cidade
            , localidade.dsc_estado
            , localidade.dsc_pais
            , pedido.productid
            , produto.dsc_produto
            , pedido.customerid
            , pedido.cardtype
            , sum(pedido.quantidade) as quantidade
            , sum(pedido.vlr_unitario * pedido.quantidade) as faturamento_bruto
            , sum(pedido.vlr_unitario * (1 - pedido.vlr_desconto) * pedido.quantidade) as faturamento_com_desconto
        from pedido
        inner join localidade
        on pedido.id_ender_cobranca = localidade.addressid
        inner join produto
        on pedido.productid = produto.productid
        group by
            pedido.pedido_id
            , pedido.data_pedido
            , localidade.dsc_cidade
            , localidade.dsc_estado
            , localidade.dsc_pais
            , pedido.productid
            , produto.dsc_produto
            , pedido.customerid
            , pedido.creditcardid
            , pedido.cardtype
    )

select *
from joined