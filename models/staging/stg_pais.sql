with 
    pais as (
        select * 
        from {{source('data_adventure_works', 'COUNTRYREGION')}}
)

, new_table as (
    select 
        cast(COUNTRYREGIONCODE as varchar) as sigla_pais
        ,cast(NAME as varchar) as nome_pais
        ,cast(MODIFIEDDATE as date) as data_atualizacao_pais
    from pais
)

select *
from new_table
