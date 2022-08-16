properties = [ {
    name = "batchapps",
    region = "us-east-1",
    amiId = "ami-0a710a51fe1592455",
    instanceType = "t3.large",
    subnetId = "subnet-0fc82846cd77a18fe",
    securityGroup = ["sg-200f325e"],
    iam = "infra-read-only-access", 
    keyName = "Virginia_Staging_Keypair",
    ip = [],
    volumeSize = "20",
    volumetype = "gp3",
    KmsKeyId = "2f29c82d-4e89-4f22-b551-a7357dcb6e8f",
    no_of_instances = "2"
}
]