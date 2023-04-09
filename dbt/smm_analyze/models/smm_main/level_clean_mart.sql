{{ config(
    materialized='table',
    partition_by={
      "field": "clear_time",
      "data_type": "timestamp",
      "granularity": "month"
    },
    cluster_by = "gameStyle"
)}}

with clears as
    (select * from {{ref('clears')}}),
    players as
    (select * from {{ref('players') }}),
    courses as 
    (select * from {{ref('courses')}})
select clears.catch as clear_time, clears.id as level_id, clears.player as player_id, flag, difficulty, gameStyle, 
title, creation as creation_time
from clears join players on clears.player = players.id
join courses on courses.id = clears.id



