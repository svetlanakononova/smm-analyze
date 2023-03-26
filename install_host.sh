#!/bin/sh

PROJECT_ID=smm-analyze-project
ACCOUNT_ID=email
BILLING_ACCOUNT_ID=bil_account_id

#gcloud config set account $ACCOUNT_ID
#gcloud projects create $PROJECT_ID --set-as-default
#gcloud beta billing projects link $PROJECT_ID --billing-account $BILLING_ACCOUNT_ID
#gcloud auth application-default login
#gcloud services enable compute.googleapis.com
#gcloud iam service-accounts create smm-analyze-adm --display-name="SMM analyze Service Account"
#gcloud iam service-accounts keys create ~/.google/creds/google_creds.json --iam-account=smm-analyze-adm@$PROJECT_ID.iam.gserviceaccount.com
scp  ~/.google/creds/google_creds.json project-test:.gc