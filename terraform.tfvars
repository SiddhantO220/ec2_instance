properties = [ {
    name = "Kristal-Staging-BatchApps-new",
    region = "us-east-1",
    amiId = "ami-0d10cba870312da51",
    instanceType = "t3.large",
    subnetId = "subnet-0fc82846cd77a18fe",
    securityGroup = ["sg-200f325e"],
    iam = "infra-read-only-access", 
    keyName = "Virginia_Staging_Keypair",
    privIp = [],
    volumeSize = "20",
    volumetype = "gp3",
    KmsKeyId = "2f29c82d-4e89-4f22-b551-a7357dcb6e8f",
    no_of_instances = "1"
}, 
{
    name = "Kristal-Staging-Services-New",
    region = "us-east-1",
    amiId = "ami-0d10cba870312da51", 
    instanceType = "c5.xlarge",
    subnetId = "subnet-0b71d9f2bfc8cdaba",
    securityGroup = ["sg-252c1d5b"],
    iam = "infra-read-only-access", 
    keyName = "Virginia_Staging_Keypair",
    privIp = ["10.0.8.61","10.0.8.62","10.0.8.63","10.0.8.64","10.0.8.65","10.0.8.66"],
    volumeSize = "30",
    volumetype = "gp3",
    KmsKeyId = "2f29c82d-4e89-4f22-b551-a7357dcb6e8f",
    no_of_instances = "6"
}
]