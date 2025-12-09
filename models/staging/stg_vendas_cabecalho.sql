with 
    vendas_cabecalho as (
        select * 
        from {{source('data_adventure_works', 'SALESORDERHEADER')}}
)

, new_table as (
    select 
        cast(SALESORDERID as int) as pk_id_pedido_venda
        ,cast(CUSTOMERID as int) as fk_id_cliente
        ,cast(SALESPERSONID as int) as fk_id_vendedor
        ,cast(TERRITORYID as int) as fk_id_territorio
        ,cast(BILLTOADDRESSID as int) as fk_id_endereco_fatura
        ,cast(SHIPTOADDRESSID as int) as fk_id_endereco_entrega
        ,cast(CREDITCARDID as int) as fk_id_cartao_credito
        ,cast(CURRENCYRATEID as int) as fk_id_taxa_moeda
        ,cast(REVISIONNUMBER as varchar) as numero_revisao_pedido
        ,cast(ORDERDATE as date) as data_pedido
        ,cast(DUEDATE as date) as data_prazo_entrega
        ,cast(SHIPDATE as date) as data_despacho_mercadoria
        ,cast(STATUS as varchar) as status_pedido
        ,case
            when STATUS = '1' then 'Em Processo'
            when STATUS = '2' then 'Aprovado'
            when STATUS = '3' then 'Em espera'
            when STATUS = '4' then 'Recusado'
            when STATUS = '5' then 'Enviado'
            when STATUS = '6' then 'Cancelado'
        end as descricao_status
        ,case
            when ONLINEORDERFLAG = '1' then 'Venda Online'
            when ONLINEORDERFLAG = '2' then 'Venda Lojista'
        end as tipo_venda
        ,cast(PURCHASEORDERNUMBER as varchar) as numero_ordem_compra
        ,cast(ACCOUNTNUMBER as varchar) as numero_conta
        ,cast(CREDITCARDAPPROVALCODE as varchar) as codigo_aprovacao_cartao_credito
        ,cast(SUBTOTAL as numeric(18,2)) as valor_bruto_venda
        ,cast(TAXAMT as numeric(18,2)) as valor_total_impostos
        ,cast(FREIGHT as numeric(18,2)) as valor_total_frete
        ,cast(TOTALDUE as numeric(18,2)) as valor_total         
    from vendas_cabecalho
)

select *
from new_table
