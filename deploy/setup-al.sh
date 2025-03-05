#!/bin/bash

# setup Amazon Linux 2023 for Docker and Docker Compose
set -e

# Docker
sudo yum update
sudo yum install docker -y
sudo systemctl enable docker
sudo systemctl start docker
sudo usermod -a -G docker ec2-user
newgrp docker

# Docker Compose
sudo curl -L https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m) \
    -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

# Pull data required for Germany
docker-compose run feed download --wiki --grid
docker run -v /data/data:/tileset openmaptiles/openmaptiles-tools download-osm germany

# Setup
docker-compose -f docker-compose-setup.yml up -d

# bail out here 
exit

# to download and execute this:
N7M_VERSION=v0.9.8 \
 && curl -O -L https://github.com/GPS4PETS/n7m/archive/refs/tags/$N7M_VERSION.tar.gz \
 && tar xvf $N7M_VERSION.tar.gz --strip-components=1 \
 && cd deploy \
 && ./setup-al.sh
