# Download plugins
packer {
	required_plugins {
		amazon = {
			version = ">= 0.0.1"
			source = "github.com/hashicorp/amazon"
		}
	}
}

# Configuration for machine
source "amazon-ebs" "image" {
	ami_name             = "golden-image {{timestamp}}"
	ssh_private_key_file = "/home/cloudshell-user/.ssh/id_rsa"
	ssh_keypair_name     = "packer"
	instance_type        = "t2.micro"
	ssh_username         = "ec2-user"
	region               = "us-east-1"
	source_ami           = "ami-0e8384ca18e95b930"
    ami_users            = [
        "106626448108",
        "354918394522"
    ]

    // ami_regions          = [
    //     "us-west-2", 
    //     "us-west-1", 
    //     "us-east-2", 
    //     "eu-west-1"
    // ]
	run_tags = {
		Name = "Packer instance for golden-image"
	}
}
