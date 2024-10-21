data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_instance" "web" {
  count         = 5
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t3.micro"
  availability_zone = "us-east-1"
  user_data = <<-EOF
              #!/bin/bash
              apt-get update -y
              apt-get install apache2 -y
              systemctl start apache2
              systemctl enable apache2
              echo "<h1>Welcome to Terraform Class 2</h1>" > /var/www/html/index.html
              EOF

  tags = {
    Name = "HelloWorld"
  }
}