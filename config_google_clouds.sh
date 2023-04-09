#!/bin/bash

#Change this parameters
ACCOUNT_ID=<google_account>
BILLING_ACCOUNT_ID=<billing_account_id>
VM_USER_NAME=<username>


PROJECT_ID=smm-analyze-prj
SERVICE_ACCOUNT_NAME=smm-analyze-adm
VM_INSTANCE_NAME=smm-project-vm
REGION=europe-west1-b

gcloud components install beta
gcloud auth login
gcloud config set account $ACCOUNT_ID
gcloud projects create $PROJECT_ID 
gcloud config set project $PROJECT_ID
gcloud beta billing projects link $PROJECT_ID --billing-account $BILLING_ACCOUNT_ID
gcloud services enable compute.googleapis.com
gcloud iam service-accounts create $SERVICE_ACCOUNT_NAME --display-name="SMM analyze Service Account"
gcloud iam service-accounts keys create ~/.google/creds/google_creds.json --iam-account=$SERVICE_ACCOUNT_NAME@$PROJECT_ID.iam.gserviceaccount.com

gcloud projects add-iam-policy-binding $PROJECT_ID --member=serviceAccount:$SERVICE_ACCOUNT_NAME@$PROJECT_ID.iam.gserviceaccount.com --role=roles/storage.admin
gcloud projects add-iam-policy-binding $PROJECT_ID --member=serviceAccount:$SERVICE_ACCOUNT_NAME@$PROJECT_ID.iam.gserviceaccount.com --role=roles/bigquery.admin
gcloud projects add-iam-policy-binding $PROJECT_ID --member=serviceAccount:$SERVICE_ACCOUNT_NAME@$PROJECT_ID.iam.gserviceaccount.com --role=roles/storage.objectAdmin
gcloud projects add-iam-policy-binding $PROJECT_ID --member=serviceAccount:$SERVICE_ACCOUNT_NAME@$PROJECT_ID.iam.gserviceaccount.com --role=roles/viewer


gcloud compute instances create $VM_INSTANCE_NAME \
    --project=$PROJECT_ID \
    --zone=$REGION \
    --machine-type=e2-standard-2 \
    --network-interface=network-tier=PREMIUM,subnet=default \
    --maintenance-policy=MIGRATE \
    --provisioning-model=STANDARD \
    --scopes=https://www.googleapis.com/auth/devstorage.read_only,https://www.googleapis.com/auth/logging.write,https://www.googleapis.com/auth/monitoring.write,https://www.googleapis.com/auth/servicecontrol,https://www.googleapis.com/auth/service.management.readonly,https://www.googleapis.com/auth/trace.append \
    --create-disk=auto-delete=yes,boot=yes,device-name=$VM_INSTANCE_NAME,image=projects/ubuntu-os-cloud/global/images/ubuntu-minimal-2204-jammy-v20230302,mode=rw,size=30,type=projects/$PROJECT_ID/zones/$REGION/diskTypes/pd-balanced \
    --no-shielded-secure-boot \
    --shielded-vtpm \
    --shielded-integrity-monitoring \
    --labels=ec-src=vm_add-gcloud \
    --reservation-affinity=any

gcloud config set compute/zone $REGION    
REMOTE_HOST=`gcloud compute instances describe $VM_INSTANCE_NAME --format='get(networkInterfaces[0].accessConfigs[0].natIP)'`

    
mkdir ~/.ssh
ssh-keygen -t rsa -f ~/.ssh/gckey -b 2048 -N "" -C $VM_USER_NAME
echo "$VM_USER_NAME:$(less ~/.ssh/gckey.pub | cut -f1 -f2 -d' ')" >gckey_gc.pub

echo "Host $VM_INSTANCE_NAME" >> ~/.ssh/config
echo "    Hostname $REMOTE_HOST" >> ~/.ssh/config
echo "    User $VM_USER_NAME" >> ~/.ssh/config
echo "    IdentityFile ~/.ssh/gckey" >> ~/.ssh/config
echo "    StrictHostKeyChecking=no" >> ~/.ssh/config
echo "    UserKnownHostsFile=/dev/null" >> ~/.ssh/config

gcloud compute project-info add-metadata --metadata-from-file ssh-keys=gckey_gc.pub
rm gckey_gc.pub

