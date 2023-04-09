#!/bin/bash

python ~/smm-analyze/prefect/create_google_blocks.py 

prefect deployment build ~/smm-analyze/prefect/main_flow.py:mainflow  -n "SMM data process" --cron "0 12 * * *"
prefect deployment apply mainflow-deployment.yaml 
prefect deployment run "mainflow/SMM data process"

prefect agent start -q "default" &
prefect orion start &
