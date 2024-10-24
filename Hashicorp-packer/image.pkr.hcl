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
	run_tags = {
		Name = "Packer instance for golden-image"
	}
}

# Build image
build {
	sources = [
		"source.amazon-ebs.image"
	]
}