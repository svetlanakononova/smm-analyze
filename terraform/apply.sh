#!/bin/sh

export GOOGLE_APPLICATION_CREDENTIALS=~/.google/google_creds.json
export TF_VAR_region="eu-west-1"
export TF_VAR_project="smm-analyze-project"
export TF_VAR_bucket="smm-data-bucket"
export TF_VAR_rawdataset="smm-raw-dataset"
export TF_VAR_stagedataset="smm-staging"
export TF_VAR_dwh="smm-main"

terraform init
terraform apply

