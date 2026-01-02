with 
    detalhe_venda as (
        select
            cast(SALESORDERDETAILID as int) as pk_id_detalhe_venda
            ,cast(SALESORDERID as int) as fk_id_cabecalho_venda
            ,cast(PRODUCTID as int) as fk_id_produto
            ,cast(SPECIALOFFERID as int) as fk_id_oferta_especial  
            ,cast(ORDERQTY as int) as quantidade_venda_detalhe
            ,cast(UNITPRICE as numeric(18,4)) as preco_unitario_detalhe_venda
            ,cast(UNITPRICEDISCOUNT as numeric(18,4)) as perc_desconto_detalhe_venda
            ,cast(CARRIERTRACKINGNUMBER as varchar) as numero_rastreio_detalhe_venda
        from  {{source('erp_adventure_works','SALESORDERDETAIL')}}
    )   

select * 
from detalhe_venda