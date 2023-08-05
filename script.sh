#!/usr/bin/env sh
# example of scrip to be executed on packer launch
echo "hello world" > /home/ubuntu/packer.test

# Pull Dan's latest script  on rebuilds
cd /home/ubuntu/pve-consumer-deployment;
git reset --hard;
git pull;

# removing old artifacts
rm /home/ubuntu/pve-consumer-deployment/.consumer.lock;
sudo groupadd -g 1337 flags;
sudo usermod -aG 1001 ubuntu;
sudo usermod -aG 1337 ubuntu;

#removing ubuntu user from sudo group
sudo gpasswd -d ubuntu sudo
