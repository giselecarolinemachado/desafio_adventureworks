with 
    city as  (
        select *
        from {{ref("stg_endereco")}}
    )
    ,estado as (
        select *
        from {{ref("stg_estado")}}
    )
    ,pais as (
        select *
        from {{ref("stg_regiao_pais")}}
    )

    ,local as (
        select
            city.pk_id_endereco as Id_Endereco
            ,city.cidade as "Cidade"
            ,city.endereco as "Endereço Completo"
            ,estado.sigla_estado as "Estado"
            ,pais.nome_pais as "País"
            ,pais.sigla_pais as "Código País"
            from cidade 
            left join estado on pk_id_estado = fk_id_estado 
            left join pais on sigla_estado = sigla_pais
    )

    select *
    from local