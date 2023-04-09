#!/bin/sh

cd 

mkdir .google
mv .gc .google/google_creds.json

sudo apt update && sudo apt-get -y install git nano
git clone https://github.com/svetlanakononova/smm-analyze.git

#Install Anaconda
wget https://repo.anaconda.com/archive/Anaconda3-2023.03-Linux-x86_64.sh
chmod +x Anaconda3-2023.03-Linux-x86_64.sh
./Anaconda3-2023.03-Linux-x86_64.sh -b
rm Anaconda3-2023.03-Linux-x86_64.sh
~/anaconda3/bin/conda init 

export PATH="${HOME}/anaconda3/bin:${PATH}"

#terraform

sudo apt-get update && sudo apt-get install -y gnupg software-properties-common
wget -O- https://apt.releases.hashicorp.com/gpg | gpg --dearmor | sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
sudo apt update && sudo apt-get install terraform

#prefect and dbt
cd ~/smm-analyze/prefect
./install_prefect.sh

cd ~/smm-analyze/dbt
./install_dbt.sh

#run terraform

cd ~/smm-analyze/terraform
./apply.sh


#run flow
cd ~/smm-analyze/prefect
./run_flow.py
