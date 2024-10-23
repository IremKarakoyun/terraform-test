variable "region" {
  description = "The AWS region to deploy the infrastructure"
  type        = string
  default     = "us-east-1"
}

variable "key_name" {
  description = "The name of the key pair to use for SSH access"
  type        = string
  default     = "advanced-terraform"
}

variable "cidr_block" {
  description = "The CIDR block for the VPC"
  type        = string
  default     = ""
}