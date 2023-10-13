packer {
  required_plugins {
    amazon = {
      source  = "github.com/hashicorp/amazon"
      version = "~> 1"
    }
    ansible = {
      source  = "github.com/hashicorp/ansible"
      version = "~> 1"
    }
  }
}

source "amazon-ebs" "ubuntu" {
  ami_name      = "Packer-Golden-img-DEFCON"
  instance_type = "t2.xlarge"
  region        = "us-west-2"
  vpc_id = "vpc-VPC_ID_GOES_HERE"
  subnet_id = "subnet-SUBNET_ID_GOES_HERE"
  security_group_id = "sg-SECURITY_GROUP_ID_GOES_HERE"
  ssh_username = "ubuntu"
  ssh_private_key_file = "/home/ubuntu/.ssh/id_rsa"
  iam_instance_profile = "ECR_SSM_ROLE_GOES_HERE"
  associate_public_ip_address = true

  source_ami_filter {
    filters = {
      image-id = "ami-AMI_SRC_GOES_HERE"
      
    }
    most_recent = true
    owners      = ["AWS_ACCOUNT_ID_HERE"]
  }

  tags = {
    Name = "Packer_Build_GoldenImage_update_compose" # this will be the "name" of the image
  }
}

build {
  name = "ansible-provision"

  sources = [
    "source.amazon-ebs.ubuntu"
  ]

  provisioner "shell" {
    script = "script.sh"
    remote_folder = "/home/ubuntu/"
  }
}
