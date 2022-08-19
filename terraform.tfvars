properties = [ {
    name = "Kristal-Staging-BatchApps-New",
    region = "us-east-1",
    amiId = "ami-05aa06f06ab850109",
    instanceType = "t3.large",
    subnetId = "subnet-0fc82846cd77a18fe",
    securityGroup = ["sg-200f325e"],
    iam = "infra-read-only-access", 
    keyName = "Virginia_Staging_Keypair",
    privIp = [],
    volumeSize = "20",
    no_of_instances = "1",
    file = ["user-data.batchapps-leader"]
}, 
{
    name = "Kristal-Staging-Services-New",
    region = "us-east-1",
    amiId = "ami-05aa06f06ab850109", 
    instanceType = "c5.xlarge",
    subnetId = "subnet-0b71d9f2bfc8cdaba",
    securityGroup = ["sg-252c1d5b"],
    iam = "infra-read-only-access", 
    keyName = "Virginia_Staging_Keypair",
    privIp = ["10.0.8.61","10.0.8.62","10.0.8.63","10.0.8.64","10.0.8.65","10.0.8.66"],
    volumeSize = "30",
    no_of_instances = "6",
    file = ["user-data.service-leader", "user-data.service-manager"]
}
]