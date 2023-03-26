#!/bin/sh

#//TODO: добавить условия на выполнения блоков

#Install Anaconda
#wget https://repo.anaconda.com/archive/Anaconda3-2023.03-Linux-x86_64.sh
#chmod +x Anaconda3-2023.03-Linux-x86_64.sh
#./Anaconda3-2023.03-Linux-x86_64.sh
#rm Anaconda3-2023.03-Linux-x86_64.sh

#Install docker and docker-compose

#sudo apt-get -y update
#sudo apt-get -y install docker.io


#mkdir bin
#cd bin
#wget https://github.com/docker/compose/releases/download/v2.2.3/docker-compose-linux-x86_64 -O docker-compose
#chmod +x docker-compose
#cd 
#echo 'export PATH="${HOME}/bin:${PATH}"' >>  ~/.bashrc


#install gcloudsdk

sudo apt-get install -y apt-transport-https ca-certificates gnupg
echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key --keyring /usr/share/keyrings/cloud.google.gpg add -
sudo apt-get install -y google-cloud-cli
gcloud init


