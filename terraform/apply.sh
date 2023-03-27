#!/bin/sh

export GOOGLE_APPLICATION_CREDENTIALS=~/.google/google_creds.json
export TF_VAR_region="eu-west-1"
export TF_VAR_project="smm-analyze-project"
export TF_VAR_bucket="smm_data_bucket"
export TF_VAR_rawdataset="smm_raw_dataset"
export TF_VAR_stagedataset="smm_staging"
export TF_VAR_dwh="smm_main"

terraform init
terraform apply -auto-approve

