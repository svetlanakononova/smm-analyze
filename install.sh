#!/bin/sh

#Install Anaconda
wget https://repo.anaconda.com/archive/Anaconda3-2023.03-Linux-x86_64.sh
chmod +x Anaconda3-2023.03-Linux-x86_64.sh
./Anaconda3-2023.03-Linux-x86_64.sh
rm Anaconda3-2023.03-Linux-x86_64.sh

#Install docker and docker-compose

sudo apt-get -y update
sudo apt-get -y install docker.io


mkdir bin
cd bin
wget https://github.com/docker/compose/releases/download/v2.2.3/docker-compose-linux-x86_64 -O docker-compose
chmod +x docker-compose
cd 
echo 'export PATH="${HOME}/bin:${PATH}"' >>  ~/.bashrc

