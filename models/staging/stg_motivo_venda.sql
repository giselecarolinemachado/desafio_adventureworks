with 
    motivo_venda as (
        select *
        from  {{ source('erp_adventure_works','SALESREASON') }}
    )

    ,dados_motivo_venda as (
        select
            cast(SALESREASONID as int) as pk_id_venda_motivo
            ,cast(NAME as string) as nome_motivo_venda
            ,cast(REASONTYPE as string) as tipo_motivo_venda
            ,cast(MODIFIEDDATE as date) as data_modificacao_motivo_venda
        from venda_motivo
)

select * 
from dados_motivo_venda