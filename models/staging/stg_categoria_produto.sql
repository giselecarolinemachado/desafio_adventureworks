with 
    categoria_produto as (
        select * 
        from {{source('data_adventure_works', 'PRODUCTCATEGORY')}}
)

, new_table as (
    select 
        cast(PRODUCTCATEGORYID as int) as pk_id_categoria_produto
        ,cast(name as string) as nome_produto
        ,cast(MODIFIEDDATE as date) as data_modificacao_produto
    from categoria_produto
)

select *
from new_table


