provider "aws" {
  region = "eu-west-1"
}

resource "aws_instance" "my_instance" {
  ami           = "ami-acd005d5" # Amazon Linux AMI 2017.09
  instance_type = "t2.micro"

  security_groups = ["${aws_security_group.my_security_group.name}"]
}

resource "aws_security_group" "my_security_group" {
  name        = "terraform-workshop-sg"
  description = "Terraform workshop security group"

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
