with 
    cartao_credito as  (
        select *
        from {{ref("stg_cartao_credito")}}
    )
    ,cartao_credito_pessoa (
        select *
        from {{ref("stg_cartao_credito_pessoa")}}
    )

    ,cartao_credito_final as (
        select
            cartao_credito.pk_id_cartao_credito as id_cartao_credito
            ,cartao_credito_pessoa.pk_id_identidade_pessoa as id_identidade_pessoa
            ,cartao_credito.cartao_credito_tipo as "Tipo Cartão"
            ,cartao_credito.numero_cartao_credito as "Número Cartão"
            ,cartao_credito.cartao_mes_expiracao as "Mês Vencimento"
            ,cartao_credito.cartao_ano_expiracao as "Ano Vencimento"
            ,cartao_credito.cartao_credito_data_modificacao as "Última Data Modificação"
            from cartao_credito
            left join cartao_credito_pessoa on pk_id_cartao_credito = fk_id_cartao_credito
    )

    select *
    from cartao_credito_final