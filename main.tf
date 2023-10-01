provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "example_instance" {
  ami           = "ami-03a6eaae9938c858c" # Use the specified AMI ID
  instance_type = "t2.micro"             # Use the specified instance type
  key_name      = "ssh-key"        # Replace with your key pair name
  vpc_security_group_ids = [aws_security_group.allow_all.id]
}

resource "aws_security_group" "allow_all" {
  name        = "allow-all-security-group"
  description = "Security group allowing all inbound and outbound traffic"

  ingress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

output "ssh_command" {
  value = "ssh -i ssh-key.pem ec2-user@${aws_instance.example_instance.public_ip}"
}
