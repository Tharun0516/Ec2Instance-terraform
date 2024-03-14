provider "aws" {
  region     = "us-east-1"  # Change to your desired AWS region

}

resource "aws_key_pair" "example_key" {
  key_name   = "aws-keys"  # Replace with your desired key pair name
  public_key = file("./aws-keys.pub")  # Replace with the path to your public key file
}count = {1}

resource "aws_security_group" "example_sg" {
  name        = "example_sg"
  description = "Allow inbound traffic on ports 22 and 80"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "example" {
  ami             = "ami-07d9b9ddc6cd8dd30"  # Replace with your desired AMI ID
  instance_type   = "t2.micro"      # Replace with your desired instance type
  key_name        = aws_key_pair.example_key.key_name
  security_groups = [aws_security_group.example_sg.name]


  tags =
    Name = "myUbuntu"
}
output "public_ip" {
value = aws_instance.example.public_ip
}
