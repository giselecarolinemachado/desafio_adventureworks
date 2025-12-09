with 
    subcategoria_produto as (
        select * 
        from {{source('data_adventure_works', 'PRODUCTSUBCATEGORY')}}
)

, new_table as (
    select 
        cast(PRODUCTSUBCATEGORYID as int) as pk_id_subcategoria_produto
        ,cast(PRODUCTCATEGORYID as int) as fk_id_categoria_produto
        ,cast(name as string) as nome_produto
        ,cast(MODIFIEDDATE as date) as data_modificacao_produto
    from subcategoria_produto
)

select *
from new_table