
{{ config(materialized='table') }}

select *
from {{ source('smm_raw_dataset','players_ext') }}

