with 
    detalhe_vendas as (
        select *
        from {{ref("stg_detalhe_venda")}}
    )

    ,cabecalho_vendas as (
        select *
        from {{ref("stg_vendas_cabecalho")}}
    )

    ,produtos as (
        select *
        from {{ref("stg_produto")}}
    )

    ,vendas as (
        select 
            {{ dbt_utils.generate_surrogate_key(
                ['cabecalho_vendas.pk_id_pedido_venda', 'detalhe_vendas.pk_id_detalhe_venda']
            ) }} as sk_pedido_produto
            ,cabecalho_vendas.pk_id_pedido_venda
            ,detalhe_vendas.pk_id_detalhe_venda
            ,cabecalho_vendas.fk_id_cliente
            ,cabecalho_vendas.fk_id_vendedor
            ,cabecalho_vendas.fk_id_territorio
            ,cabecalho_vendas.fk_id_endereco_fatura 
            ,cabecalho_vendas.fk_id_endereco_entrega
            ,cabecalho_vendas.fk_id_metodo_entrega
            ,cabecalho_vendas.fk_id_cartao_credito
            ,cabecalho_vendas.fk_id_taxa_moeda
            ,detalhe_vendas.fk_id_produto
            ,detalhe_vendas.fk_id_venda_oferta_especial
            ,cabecalho_vendas.data_pedido
            ,cabecalho_vendas.data_prazo_entrega
            ,cabecalho_vendas.data_despacho_mercadoria
            ,cabecalho_vendas.valor_bruto_venda
            ,cabecalho_vendas.valor_total_impostos
            ,cabecalho_vendas.valor_total_frete
            ,cabecalho_vendas.valor_total  
            ,detalhe_vendas.quantidade_venda_detalhe
            ,detalhe_vendas.preco_unitario_detalhe_venda
            ,detalhe_vendas.perc_desconto_detalhe_venda
            ,produtos.custo_padrao_produto
            ,cabecalho_vendas.numero_revisao_pedido
            ,cabecalho_vendas.status_pedido
            ,cabecalho_vendas.descricao_status
            ,cabecalho_vendas.tipo_venda
            ,cabecalho_vendas.numero_ordem_compra
            ,cabecalho_vendas.numero_conta
            ,cabecalho_vendas.codigo_aprovacao_cartao_credito           
        from detalhe_vendas
        left join cabecalho_vendas on cabecalho_vendas.pk_id_pedido_venda = detalhe_vendas.fk_id_cabecalho_venda
        left join produtos on produtos.pk_id_produto = detalhe_vendas.fk_id_produto
        order by cabecalho_vendas.data_pedido, cabecalho_vendas.pk_id_pedido_venda
    )

    , medidas as (
        select 
            *
            , quantidade_venda_detalhe * preco_unitario_detalhe_venda as valor_bruto_vendas
            , quantidade_venda_detalhe * (preco_unitario_detalhe_venda * (1- perc_desconto_detalhe_venda)) as valor_liquido_vendas
            , valor_bruto_vendas - (custo_padrao_produto * quantidade_venda_detalhe) as margem_bruta_vendas
            , valor_liquido_vendas - (custo_padrao_produto * quantidade_venda_detalhe) as margem_liquida_vendas
            , valor_total_frete / (count(*) over(partition by pk_id_pedido_venda)) as rateio_frete
        from vendas_enriquecida
    )

    , final as (
        select
            sk_produto_pedido
            ,pk_id_pedido_venda as Nota_Fiscal
            ,pk_id_detalhe_venda as Id_Ordem_Pedido
            ,fk_id_cliente as Id_Cliente
            ,fk_id_vendedor as Id_Vendedor
            ,fk_id_territorio as Id_Territorio
            ,fk_id_endereco_fatura as Id_Endereco_Fatura
            ,fk_id_endereco_entrega as Id_Endereco_Entrega
            ,fk_id_metodo_entrega as Id_Metodo_Entrega
            ,fk_id_cartao_credito as Id_Cartao_de_Credito
            ,fk_id_taxa_moeda as Id_Taxa_de_Cambio
            ,fk_id_produto as Id_Produto
            ,fk_id_venda_oferta_especial as Id_Codigo_Promocional
            ,data_pedido as "Data do Pedido"
            ,data_prazo_entrega as "Prazo de Entrega - Data"
            ,data_despacho_mercadoria as "Data de Envio do Produto"
            ,valor_bruto_venda as "Subtotal NF"
            ,valor_total_impostos as "Impostos e Deduções"
            ,valor_total_frete as "Valor Total Frete"
            ,valor_total as "Total NF" 
            ,quantidade_venda_detalhe as "Quantidade de Produto"
            ,preco_unitario_detalhe_venda as "Valor Unitário"
            ,perc_desconto_detalhe_venda as "Desconto (Percentual)"
            ,custo_padrao_produto as "Custo Produto" 
            ,castvalor_bruto_vendas as numeric(18,4)) as "Valor Total Bruto" 
            ,cast(valor_liquido_vendas as numeric(18,2)) as "Valor Total Líquido" 
            ,cast(margem_bruta_vendas as numeric(18,2)) as "Margem Bruta" 
            ,cast(margem_liquida_vendas as numeric(18,2)) as "Margem Líquida" 
            ,cast(rateio_frete as decimal) as "Rateio Valor Frete"
            ,numero_revisao_pedido as "Número de Revisão do Pedido"
            ,status_pedido as "Código Status Pedido"
            ,descricao_status as "Status do Pedido"
            ,tipo_venda as "Tipo de Venda"
            ,numero_ordem_compra as "Número Ordem/Pedido de Compra"
            ,numero_conta as "Número Conta"
            ,codigo_aprovacao_cartao_credito as "Código Aprovação Cartão de Crédito"
            from medidas
        )

select * 
from final