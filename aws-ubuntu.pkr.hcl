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
  ami_name      = "Packer-Golden-img-DEFCON-intern-v7"
  instance_type = "t2.xlarge"
  region        = "us-east-1"
  vpc_id = "vpc-0481f270f497d012a"
  subnet_id = "subnet-04d0f1a7ff78c4e29"
  #security_group_id = "sg-00db65aa784f0f66c"
  ssh_username = "ubuntu"
  ssh_private_key_file = "/home/ubuntu/.ssh/botb"
  iam_instance_profile = "JaredsTestRoleforECRandSSM"
  associate_public_ip_address = true

  source_ami_filter {
    filters = {
      image-id = "ami-0d0bdf240bbd36aa6"
    }
    most_recent = true
    owners      = ["102272822897"]
  }

  tags = {
    Name = "Packer_Build_GoldenImage" # this will be the "name" of the image
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
  #post-processor "vagrant" {}
}
