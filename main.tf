resource "aws_instance" "firstExample" {
	ami           = "ami-08ba8f615bb1af143"
	instance_type = "t3.micro"

	tags = {
      Name = "terraform-exmaple"
	}
}
