#!/bin/sh

export GOOGLE_APPLICATION_CREDENTIALS=~/.google/creds/google_creds.json
export TF_VAR_region=eu-west-6
export TF_VAR_project='smm-analyze'
export TF_VAR_bucket='smm-data-bucket'
export TF_VAR_rawdataset='smm-raw-dataset'
export TF_VAR_stagedataset='smm-staging'
export TF_VAR_dwh='smm-main'

terraform init
terraform apply
