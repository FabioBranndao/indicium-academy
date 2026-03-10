with
    ticket as 
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
            year(ticket.data_pedido) as ano
            , month(ticket.data_pedido) as mes 
            , localidade.dsc_cidade
            , localidade.dsc_estado
            , localidade.dsc_pais
            , ticket.productid
            , produto.dsc_produto
            , count(distinct ticket.pedido_id) numero_de_pedidos
            , sum(ticket.vlr_unitario * ticket.quantidade) as faturamento_bruto
            , sum(ticket.vlr_unitario * (1 - ticket.vlr_desconto) * ticket.quantidade) as faturamento_com_desconto
            , (
                sum(ticket.vlr_unitario * (1 - ticket.vlr_desconto) * ticket.quantidade) /
                count(distinct ticket.pedido_id)
            ) as ticket_medio  
        from ticket
        inner join localidade
        on ticket.id_ender_cobranca = localidade.addressid
        inner join produto
        on ticket.productid = produto.productid
        group by
            year(ticket.data_pedido)
            , month(ticket.data_pedido) 
            , localidade.dsc_cidade
            , localidade.dsc_estado
            , localidade.dsc_pais
            , ticket.productid
            , produto.dsc_produto
    )

select * from joined