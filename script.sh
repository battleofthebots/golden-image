#!/usr/bin/env sh
# example of scrip to be executed on packer launch
echo "hello world" > /home/ubuntu/packer.test

# Pull Dan's latest script  on rebuilds
cd /home/ubuntu/pve-consumer-deployment;
git reset --hard;
git pull;

# Remove all existing docker images
docker rm $(docker ps -a -q);

# add user to 1001 group
sudo usermod -aG sugroup ubuntu;
