# TODO: Designate a cloud provider, region, and credentials
provider "aws" {
  access_key = ""
  secret_key = ""
  region = "us-east-1"
}

# TODO: provision 4 AWS t2.micro EC2 instances named Udacity T2
resource "aws_instance" "UdacityT2AmitG" {
  ami           = "ami-01d025118d8e760db"
  count         = "4"
  instance_type = "t2.micro"
  subnet_id     = "subnet-0c6da460a9f4e6107"
  tags = {
    Name = "Udacity T2AmitG"
  }
}

# TODO: provision 2 m4.large EC2 instances named Udacity M4
#resource "aws_instance" "UdacityM4AmitG" {
#   ami           = "ami-01d025118d8e760db"
#   count         = "2"
#   instance_type = "m4.large"
#   subnet_id     = "subnet-0c6da460a9f4e6107"
#   tags = {
#     Name = "Udacity M4AmitG"
#   }
# }
