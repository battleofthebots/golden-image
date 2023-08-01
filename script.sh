#!/usr/bin/env sh
# example of scrip to be executed on packer launch
echo "hello world" > /home/ubuntu/packer.test

# Pull Dan's latest script  on rebuilds
cd /home/ubuntu/pve-consumer-deployment;
git stash && git pull;
