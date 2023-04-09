
{{ config(materialized='table') }}

select *
from {{ source('smm_raw_dataset','clears_ext') }}

