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


resource "aws_key_pair" "apr2024" {
  key_name   = "apr2024-key"
  public_key = file("~/.ssh/id_rsa.pub")
}




resource "aws_security_group" "terraform_class" {
  name        = "terraform_class"
  description = "Allow TLS inbound traffic and all outbound traffic"
}

resource "aws_vpc_security_group_ingress_rule" "allow_tls_ipv4" {
  security_group_id = aws_security_group.terraform_class.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 443
  ip_protocol       = "tcp"
  to_port           = 443
}

resource "aws_vpc_security_group_ingress_rule" "allow_tls_80" {
  security_group_id = aws_security_group.terraform_class.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}


resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.terraform_class.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}



resource "aws_instance" "web" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t3.micro"
  availability_zone = "us-east-1a"
  key_name = aws_key_pair.apr2024.key_name
  vpc_security_group_ids = [ 
    aws_security_group.terraform_class.id
   ]
  user_data = <<-EOF
              #!/bin/bash
              apt-get update -y
              apt-get install apache2 -y
              systemctl start apache2
              systemctl enable apache2
              echo "<h1>can you bring me a glass of Ice Tea Please</h1>" > /var/www/html/index.html
              EOF

  tags = {
    Name = "HelloWorld"
  }
}

variable domain_name {
    description = "The domain name for the route53 zone"
}



data "aws_route53_zone" "selected" {
  name         = var.domain_name
  private_zone = false
}

resource "aws_route53_record" "blogs" {
  zone_id = data.aws_route53_zone.selected.zone_id
  name    = "blogs.${data.aws_route53_zone.selected.name}"
  type    = "A"
  ttl     = "300"
  records = [aws_instance.web.public_ip]
}

