terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "4.26.0"
    }
  }
}

provider "aws" {
  #profile = "kristalai"
  region = "us-east-1"
}

locals {
  conf = [
    for item in var.properties : [
      for i in range(1, try(item.no_of_instances,1)+1) : {
        instance_name = "${try(item.no_of_instances,1) == 1 ? "${item.name}" : "${item.name}-${i}"}"
        amiId = item.amiId 
        ins_type = item.instanceType
        subnet = item.subnetId
        securityGroup = item.securityGroup
        iam = try(item.iam, null) 
        keyName = try(item.keyName, null)
        volumeSize = try(item.volumeSize, null)
        ip = try(item.privIp["${"${i}"-1}"], null)
        userdata = try("${"${i}" == 1 ? item.file[0] : item.file[1]}", null)
      }
    ]  
  ]
}

locals {
  instances = flatten(local.conf)
}

resource "aws_instance" "new_instances" {   
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
    user_data                 = try("${file("${each.value.userdata}")}", null)
}
