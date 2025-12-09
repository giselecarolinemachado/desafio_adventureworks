with 
    estado as (
        select * 
        from {{source('data_adventure_works', 'STATEPROVINCE')}}
)

, new_table as (
    select 
        cast(STATEPROVINCEID as int) as pk_id_estado
        ,cast(STATEPROVINCECODE as varchar) as sigla_estado
        ,cast(COUNTRYREGIONCODE as varchar) as sigla_pais
        ,cast(NAME as varchar) as nome_pais
        ,cast(MODIFIEDDATE as date) as data_atualizacao_estado
    from estado
)

select *
from new_table

