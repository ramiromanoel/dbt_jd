{{ config(
    materialized='incremental',
    unique_key='category_id',
    on_schema_change='sync_all_columns'
)}}

select * from {{ref('stg_crm__nova_tabela')}}

{% if is_incremental() %}

    where updated_at > (select max(updated_at) from {{this}})

{% endif %}