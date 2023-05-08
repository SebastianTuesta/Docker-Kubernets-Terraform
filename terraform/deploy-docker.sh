#!/bin/bash

echo "Instalando Docker"

apt-get update
apt-get install -y docker-ce docker-ce-cli containerd.io 
systemctl enable docker

echo "Installing make"
sudo apt-get -y install make


git clone https://github.com/SebastianTuesta/Docker-Kubernets-Terraform.git
cd Docker-Kubernets-Terraform/make/docker
make build_run

exit 0