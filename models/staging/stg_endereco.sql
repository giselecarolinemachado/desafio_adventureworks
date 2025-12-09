with 
    endereco as (
        select * 
        from {{source('data_adventure_works', 'ADDRESS')}}
)

, new_table as (
    select 
        cast(ADDRESSID as int) as pk_id_endereco
        ,cast(STATEPROVINCEID as int) fk_id_estado
        ,cast(ADDRESSLINE1 as varchar) as endereco
        ,cast(CITY as varchar) as cidade
        ,cast(POSTALCODE as varchar) as cep 
        ,cast(MODIFIEDDATE as date) as data_atualizacao_endereco
    from endereco
)

select *
from new_table