with 
    pessoa as (
        select * 
        from {{source('data_adventure_works', 'PERSON')}}
    )

, new_table as (
    select 
        cast(BUSINESSENTITYID as int) as pk_id_identidade_pessoa
        ,cast(PERSONTYPE as varchar) as tipo_pessoa
        , case 
            when PERSONTYPE = 'EM' then 'Colaborador'
            when PERSONTYPE = 'SP' then 'Vendedor'
            when PERSONTYPE = 'SC' then 'Contato Lojista'
            when PERSONTYPE = 'VC' then 'Contato Supply'
            when PERSONTYPE = 'GC' then 'Contato Geral'
            when PERSONTYPE = 'IN' then 'Cliente Varejo'
            else 'NA'
        end as pessoa_tipo_desc 
        ,cast(FIRSTNAME ||' '|| MIDDLENAME ||' '|| LASTNAME as varchar) as nome_pessoa
        ,cast(EMAILPROMOTION as int) as email_promocional 
        ,cast(SUFFIX as varchar) as tratamento_pessoa
        ,cast(ADDITIONALCONTACTINFO as varchar) as contato_adicional
        ,cast(MODIFIEDDATE as date) as data_modificacao_pessoa
    from pessoa
) 

select * 
from new_table