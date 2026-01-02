with 
    sellers as (
        select *
        from  {{ source('erp_adventure_works','SALESPERSON') }}
    )

    , vendedores as (
        select 
            cast (BUSINESSENTITYID as int) as pk_id_vendedor
            ,cast (TERRITORYID as int) as fk_id_territorio
            ,cast (SALESQUOTA as float) as meta_vendedor
            ,cast (BONUS as float) as bonus_vendedor
            ,cast (COMMISSIONPCT as float) as comissao_vendedor
            ,cast (SALESYTD as float) as vendas_vendedor
            ,cast (SALESLASTYEAR as float) as vendas_last_year_vendedor
            , cast (MODIFIEDDATE as date) as vendas_ultima_data_modificacao
        from vendedores
    )

select * 
from vendedores