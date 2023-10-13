# golden-image
Packer + Bash script for AMI Golden Image Configuraiton and Building.

## How to Use
1. Update aws-ubuntu.pkr.hcl w/ your AWS accounts appropriate values.
2. Update `script.sh` for commands to run. 
3. Execute `packer build`


## Troubleshooting
- Ensure you're in the right region.
- Double check subnet/vpc IDs
