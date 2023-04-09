
{{ config(materialized='table') }}

select *
from {{ source('smm_raw_dataset','course_meta_ext') }}

