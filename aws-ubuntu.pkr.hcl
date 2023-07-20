packer {
  required_plugins {
    amazon = {
      version = ">= 0.0.2"
      source  = "github.com/hashicorp/amazon"
    }
  }
}

source "amazon-ebs" "ubuntu" {
  ami_name      = "BotbGoldenImageV3"
  instance_type = "t2.medium"
  region        = "us-east-1"
  vpc_id = "vpc-0481f270f497d012a"
  subnet_id = "subnet-04d0f1a7ff78c4e29"
  security_group_id = "sg-00db65aa784f0f66c"
  ssh_username = "optimus"
  iam_instance_profile = "JaredsTestRoleforECRandSSM"
  ssh_interface = "session_manager"
  communicator         = "ssh"
  associate_public_ip_address = true

  source_ami_filter {
    filters = {
      image-id = "ami-05b5e3fca7a31ecf0"
    }
    most_recent = true
    owners      = ["102272822897"]
  }

  tags = {
    Name = "Packer_Build_GoldenImage"
  }
}

build {
  name = "ssm-execution"

  sources = [
    "source.amazon-ebs.ubuntu"
  ]

  provisioner "shell" {
    inline = ["sudo apt-get install jq"]
  }

# provisioner "ansible" {
#   playbook_file = "./playbook.yml"
# }
}
