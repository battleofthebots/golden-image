#!/bin/bash

#echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections
export DEBIAN_FRONTEND=noninteractive

sleep 320; # this is a hot fix to allow auto-updates to run in the background

sudo apt-get update -y;
sudo apt-get install -y docker-compose-plugin;

# Pull Dan's latest script  on rebuilds
cd /home/ubuntu/pve-consumer-deployment;
git reset --hard;
git pull;

# removing old artifacts
if [ -f /home/ubuntu/pve-consumer-deployment/.consumer.lock ]; then
  rm /home/ubuntu/pve-consumer-deployment/.consumer.lock;
fi

getent group flags || sudo groupadd -g 1337 flags;
sudo usermod -aG 1001 ubuntu;
sudo usermod -aG 1337 ubuntu;

#removing ubuntu user from sudo group
sudo gpasswd -d ubuntu sudo
