#!/bin/sh

mkdir .google
mv .gc .google/google_creds.json

sudo apt update && sudo apt-get -y install git nano
git clone https://github.com/svetlanakononova/smm-analyze.git


#Install Anaconda
if [ ! -d "~/anaconda3" ]; then
    wget https://repo.anaconda.com/archive/Anaconda3-2023.03-Linux-x86_64.sh
    chmod +x Anaconda3-2023.03-Linux-x86_64.sh
    ./Anaconda3-2023.03-Linux-x86_64.sh -b
    rm Anaconda3-2023.03-Linux-x86_64.sh
fi

#Install docker and docker-compose

sudo apt-get -y update
sudo apt-get -y install docker.io


mkdir bin
cd bin
wget https://github.com/docker/compose/releases/download/v2.2.3/docker-compose-linux-x86_64 -O docker-compose
chmod +x docker-compose
cd 
echo 'export PATH="${HOME}/bin:${PATH}"' >>  ~/.bashrc


#terraform

sudo apt-get update && sudo apt-get install -y gnupg software-properties-common
wget -O- https://apt.releases.hashicorp.com/gpg | gpg --dearmor | sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
sudo apt update && sudo apt-get install terraform

cd smm-analyze

cd terraform
./apply.sh

cd ../prefect

conda create -n smmenv python=3.9
conda activate smmenv

pip install -r reqs.txt
