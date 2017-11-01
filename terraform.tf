provider "aws" {
  region = "eu-west-1"
}

resource "aws_instance" "my_instance" {
  ami           = "ami-acd005d5" # Amazon Linux AMI 2017.09
  instance_type = "t2.micro"
}
