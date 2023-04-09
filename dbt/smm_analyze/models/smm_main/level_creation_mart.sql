{{ config(
    materialized='table',
    partition_by={
      "field": "creation_time",
      "data_type": "timestamp",
      "granularity": "month"
    },
    cluster_by = "gameStyle"
)}}

with course_meta as 
    (select * from {{ref('course_meta')}}), 
    last_meta as 
    (select id, firstClear, tag, stars, players, clears, attempts, clearRate from (
         select id, firstClear, tag, stars, players, clears, attempts, clearRate,
	    row_number() over (partition by id order by catch desc) rn from smm_staging.course_meta
	) where rn = 1
    ),
    courses as
    (select * from {{ref('courses')}}),
    players as
    (select * from {{ref('players')}})
select courses.id as level_id, difficulty, gameStyle,
title, creation as creation_time, firstClear, tag, stars, course_meta.players as players_count, clears as clear_count, 
attempts as attempts_count, clearRate,
players.id as maker_id, players.name as maker_name, players.flag as maker_flag  from courses 
left join last_meta  course_meta
on course_meta.id = courses.id
left join players on players.id = courses.maker



