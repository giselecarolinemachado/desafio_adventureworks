with 
    stores as (
        select * 
        from  {{source('erp_adventure_works','STORE')}}
    )

    ,lojas as (
        select
            cast(BUSINESSENTITYID as varchar) as pk_id_loja
            ,cast(NAME as varchar) as nome_loja
        from lojas
    )


select * 
from renomeado