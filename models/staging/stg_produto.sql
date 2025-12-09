with 
    produto as (
        select * 
        from {{source('data_adventure_works', 'PRODUCT')}}
    )

, new_table as (
    select 
        cast(PRODUCTID as int) as pk_id_produto
        ,cast(PRODUCTSUBCATEGORYID as int) as fk_id_subcategoria_produto
        ,cast(PRODUCTMODELID as int) as fk_id_modelo_produto
        ,cast(NAME as string) as nome_produto
        ,cast(PRODUCTNUMBER as varchar) as numero_produto
        ,cast(MAKEFLAG as boolean) as flag_make_produto
        ,cast(FINISHEDGOODSFLAG as boolean) as flag_produto_acabado
        ,cast(COLOR as string) as cor_produto
        ,cast(SAFETYSTOCKLEVEL as int) as estoque_seguranca 
        ,cast(REORDERPOINT as int) as ponto_recompra_produto
        ,cast(STANDARDCOST as decimal(18,2)) as custo_padrao_produto
        ,cast(LISTPRICE as decimal(18,2)) as lista_preco
        ,cast(SIZE as varchar) as tamanho_produto 
        ,cast(SIZEUNITMEASURECODE as varchar) as cod_tamanho_medida_produto
        ,cast(WEIGHTUNITMEASURECODE as varchar) as cod_peso_produto
        ,cast(WEIGHT as decimal (18,2)) as peso_produto
        ,cast(DAYSTOMANUFACTURE as int) as tempo_producao_dias
        ,cast(PRODUCTLINE as varchar) as linha_produto
        ,cast(CLASS as varchar) as classe_produto
        ,cast(STYLE as varchar) as estilo_produto
        ,cast(MODIFIEDDATE as date) as data_modificacao_produto
    from produto    
)

select *
from new_table

