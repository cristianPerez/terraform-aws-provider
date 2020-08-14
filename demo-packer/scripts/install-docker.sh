#!/bin/bash
# Instalar Docker
#sudo yum install docker-ce docker-ce-cli containerd.io
#sudo systemctl start docker
#sudo apt-get update
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh


#Agregar el usuario centos al grupo docker
sudo groupadd docker
sudo usermod -aG docker ubuntu