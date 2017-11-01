provider "aws" {
  region = "eu-west-1"
}

resource "aws_instance" "my_instance" {
  ami           = "ami-acd005d5" # Amazon Linux AMI 2017.09
  instance_type = "t2.micro"

  security_groups = ["${aws_security_group.my_security_group.name}"]

  iam_instance_profile = "${aws_iam_instance_profile.my_instance_profile.id}"
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

resource "aws_iam_instance_profile" "my_instance_profile" {
  name = "terraform-workshop-instance-profile"
  role = "${aws_iam_role.my_role.name}"
}

resource "aws_iam_role" "my_role" {
  name = "terraform-workshop-role"
  path = "/"

  assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": "sts:AssumeRole",
            "Principal": {
               "Service": "ec2.amazonaws.com"
            },
            "Effect": "Allow",
            "Sid": ""
        }
    ]
}
EOF
}
