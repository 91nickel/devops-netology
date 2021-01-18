provider "aws" {
  region = "us-west-2"
}

//resource "aws_s3_bucket" "test_bucket" {
//  bucket = "test-bucket-netology-91nickel"
//  acl = "private"
//}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

data "aws_caller_identity" "current" {}

data "aws_region" "current" {}

data aws_instance "web" {
  for_each = local.instances[terraform.workspace]
  instance_id = aws_instance.web[each.key].id
}

locals {
  vm_count = {
    prod = "2"
    stage = "1"
  }
  vm_instance_type = {
    prod = "t2.small"
    stage = "t2.micro"
  }
  instances = {
    stage = {
      0 = "t2.micro"
    }
    prod = {
      0 = "t2.small"
      1 = "t2.small"
    }
  }
}

resource "aws_instance" "web" {
  for_each = local.instances[terraform.workspace]
  instance_type = each.value
  ami = data.aws_ami.ubuntu.id
  tags = {
    Name = "HelloNetology"
  }
  lifecycle {
    create_before_destroy = true
  }
}

//resource "aws_instance" "web" {
//  count = local.vm_count[terraform.workspace]
//  ami = data.aws_ami.ubuntu.id
//  instance_type = local.vm_instance_type[terraform.workspace]
//  tags = {
//    Name = "HelloNetology"
//  }
//}
