with 
    despacho_produto as (
        select
            cast(SHIPMETHODID as int) as pk_id_tipo_despacho
            ,cast(NAME as varchar) as nome_transportadora
            ,cast(SHIPBASE as float) as taxa_minima_metodo_despacho
            ,cast(SHIPRATE as float) as custo_kg_metodo_despacho
            ,cast(ROWGUID as varchar) as metodo_envio_guid
            ,cast(MODIFIEDDATE as date) as ultima_data_modificacao
        from  {{source('erp_adventure_works','SHIPMETHOD')}}
    )

select * from despacho_produto