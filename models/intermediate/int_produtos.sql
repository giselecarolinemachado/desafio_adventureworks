with 
    produtos as (
        select *
        from {{ref("stg_produto")}}
    )

    ,categoria_produtos as (
        select *
        from {{ref("stg_categoria_produto")}}
    )
        
    ,subcategoria_produtos as (
        select *
        from {{ref("stg_subcategoria_produto")}}
    )
    
    ,new_cte as (
        select 
            produtos.pk_id_produto  as Id_Produto
            ,produtos.nome_produto as "Nome do Produto"
            ,categoria_produtos.nome_produto as "Nome da Categoria"
            ,subcategoria_produtos.nome_produto  as "Nome da Subcategoria"
            ,produtos.produto_data_inicio_vendas as "Data de Início das Vendas"
            ,produtos.produto_data_fim_vendas as "Data Fim das Vendas"
            ,produtos.custo_padrao_produto as "Preço de Custo"
            ,produtos.lista_preco as "Preço de Venda"
        from produtos
        left join subcategoria_produtos on produtos.fk_id_produto_subcategoria = subcategoria_produtos.pk_id_produto_subcategoria
        left join categoria_produtos on subcategoria_produtos.fk_id_produto_categoria = categoria_produtos.pk_id_produto_categoria
    )

select * 
from new_cte