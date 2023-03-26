#!/bin/sh

#Install Anaconda
wget https://repo.anaconda.com/archive/Anaconda3-2023.03-Linux-x86_64.sh
chmod +x Anaconda3-2023.03-Linux-x86_64.sh
./Anaconda3-2023.03-Linux-x86_64.sh
rm Anaconda3-2023.03-Linux-x86_64.sh

#Install docker and docker-compose

sudo apt-get update
sudo apt-get install docker.io
