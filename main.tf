resource "aws_instance" "firstExample" {
	ami           = "ami-08ba8f615bb1af143"
	instance_type = "t3.micro"
	vpc_security_group_ids = [aws_security_group.securityExample.id]

	user_data = <<-EOF
				#!/bin/bash
				echo "Hello, World" > index.html
				nohup busybox httpd -f -p ${var.server_port} &
				EOF

	user_data_replace_on_change = true

	tags = {
      Name = "terraform-exmaple"
	}
}

resource "aws_security_group" "securityExample" {
	name = "terraform-example-instance"

	ingress {
		from_port   = var.server_port
		to_port     = var.server_port
		protocol    = "tcp"
		cidr_blocks = ["0.0.0.0/0"]
	}
}

variable "server_port" {
	description = "HTTP request port"
	type        = number
	default     = 8080
}

output "public_ip" {
	value = aws_instance.firstExample.public_ip
	description = "The public IP of the first example"
}
