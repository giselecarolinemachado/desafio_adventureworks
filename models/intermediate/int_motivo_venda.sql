with 
    detalhe_vendas as(
        select *
        from {{ref("stg_detalhe_venda")}}
    ) 
    ,relacao_motivos_vendas as  (
        select *
        from {{ref("stg_relacao_motivo_venda")}}
    )
    ,motivo_venda as (
        select *
        from {{ref("stg_motivo_venda")}}
    )
    
    ,motivo_venda_enriquecida as (
        select 
             {{ dbt_utils.generate_surrogate_key(
                ['detalhe_vendas.fk_id_cabecalho_venda', 'detalhe_vendas.fk_id_produto']
            ) }} as sk_produto_pedido
            ,detalhe_vendas.fk_id_vendas_cabecalho  as  NF
            ,coalesce(motivo_venda.nome_motivo_venda, 'Motivo Não Informado') as Motivo_Venda
            ,coalesce(motivo_venda.tipo_motivo_venda, 'Tipo Venda Não Informado') as Motivo_Tipo
        from detalhe_vendas
        left join relacao_motivos_vendas on relacao_motivos_vendas.pk_id_venda_motivo = detalhe_vendas.fk_id_cabecalho_venda
        left join motivo_venda on motivo_venda.pk_id_venda_motivo = relacao_motivos_vendas.fk_id_motivo_venda
select * from motivo_venda_enriquecida
    )