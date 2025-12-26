with 
    cartao_credito_pessoa as (
        select 
            cast(BUSINESSENTITYID as int) as pk_id_identidade_pessoa
            ,cast(CREDITCARDID as int) as fk_id_cartao_credito
            ,cast(MODIFIEDDATE as date) as cartao_data_modificacao
        from  {{source('erp_adventure_works','PERSONCREDITCARD')}}
)

select * from cartao_credito_pessoa