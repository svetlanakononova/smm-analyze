
{{ config(materialized='table') }}

select *
from {{ source('smm_raw_dataset','records_ext') }}

