with 
    customers as(
        select * 
        from {{ref("stg_cliente")}}
    )

    ,people as (
        select*
        from {{ref("stg_pessoa")}} 
    )
    ,lojas as (
        select *
        from {{ref("stg_lojas")}}
    )

    ,customers_final as (
        select
            customers.pk_id_cliente
            ,people.pk_id_identidade_pessoa
            ,people.tipo_pessoa
            ,people.pessoa_tipo_desc
            ,people.nome_pessoa
            ,people.email_promocional
        from customers
        left join people on customers.fk_id_pessoa = pessoas.pk_id_identidade_pessoa
        left join lojas on lojas.pk_id_loja = customers.pk_id_loja
    )

select * from customers_final