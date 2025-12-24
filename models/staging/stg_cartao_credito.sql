with 
    cartao_credito as (
        select
            cast(CREDITCARDID as int) as pk_id_cartao_credito
            ,cast(CARDTYPE as varchar) as cartao_credito_tipo
            ,cast(CARDNUMBER as varchar) as numero_cartao_credito
            ,cast(EXPMONTH as int) as cartao_credito_mes_expiracao
            ,cast(EXPYEAR as int) as cartao_credito_ano_expiracao
            ,cast(MODIFIEDDATE as date) as cartao_credito_data_modificacao
        from  {{source('erp_adventure_works','CREDITCARD')}}
)

select * from cartao_credito