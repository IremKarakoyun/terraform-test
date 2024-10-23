resource "aws_key_pair" "class5" {
  key_name   = var.key_name
  public_key = file("~/.ssh/id_rsa.pub")
}

resource "aws_vpc" "main" {
  cidr_block = var.cidr_block
}