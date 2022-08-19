terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "4.26.0"
    }
  }
}

provider "aws" {
  profile = "kristalai"
  region = "us-east-1"
}

locals {
  conf = [
    for item in var.properties : [
      for i in range(1, item.no_of_instances+1) : {            
        instance_name = "${item.name}-${i}"
        region = item.region
        amiId = item.amiId
        amiName = item.amiName 
        ins_type = item.instanceType
        subnet = item.subnetId
        securityGroup = item.securityGroup
        iam = item.iam 
        keyName = item.keyName
        volumeSize = "${item.volumeSize != null ? item.volumeSize : null}"
        ip = "${item.privIp != [] ? item.privIp["${"${i}"-1}"] : null}"
        userdata = "${"${i}" == 1 ? item.file[0] : item.file[1]}"
      }
    ]  
  ]
}

locals {
  instances = flatten(local.conf)
}

data "aws_ami" "ami_n" {
  most_recent      = true
  owners           = ["348221620929"]
  filter {
    name    = "tag:Name"
    #values  = ["${local.instances.amiName}"]
    values  = "${compact([for n in local.instances: "${n.amiName}"])}"
  }
}

resource "aws_instance" "test-instances" {   
    for_each                  = {for server in local.instances: server.instance_name => server}
    ami                       = each.value.amiId 
    instance_type             = each.value.ins_type
    subnet_id                 = each.value.subnet
    vpc_security_group_ids    = each.value.securityGroup
    tags                      = {
      "Name"                  = "${each.value.instance_name}"
    }
    iam_instance_profile      = each.value.iam
    root_block_device {
      volume_size             = each.value.volumeSize
      delete_on_termination   = true
    }
    key_name                  = each.value.keyName
    private_ip                = each.value.ip
    user_data                 = "${file("${each.value.userdata}")}" 
}