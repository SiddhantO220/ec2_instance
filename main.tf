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
        #pr_ip = cidrsubnets(item.subnetId, 8, ${item})
        for i in range(1, item.no_of_instances+1) : {
        instance_name = "${item.name}-${i}"
        region = item.region
        amiId = item.amiId
        ins_type = item.instanceType
        subnet = item.subnetId
        securityGroup = item.securityGroup
        iam = item.iam 
        keyName = item.keyName
        volumeSize = item.volumeSize
        volumetype = item.volumetype
        KmsKeyId = item.KmsKeyId
        ip = item.privIp != [] ? item.privIp : null

        #ip = pr_ip[${i-1}]
      }
    ]  
  ]
}

locals {
  instances = flatten(local.conf)
}


resource "aws_instance" "test-instances" {   
    for_each                  = {for server in local.instances: server.instance_name => server}
    ami                       = each.value.amiId
    instance_type             = each.value.ins_type
    subnet_id                 = each.value.subnet
    vpc_security_group_ids    = each.value.securityGroup
    tags                      = {
      "Name" = "${each.value.instance_name}"
    }
    iam_instance_profile      = each.value.iam
    ebs_block_device {
      device_name             = "/dev/sda1"
      kms_key_id              = each.value.KmsKeyId
      volume_size             = each.value.volumeSize
      volume_type             = each.value.volumetype
      encrypted               = true
    } 
    key_name                  = each.value.keyName
    private_ip                = each.value.ip
}