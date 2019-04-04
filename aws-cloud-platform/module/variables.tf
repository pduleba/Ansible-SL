##################################################################################
# VARIABLES
##################################################################################

variable "aws_access_key" {}
variable "aws_secret_key" {}
variable "aws_region" {}

variable "ec2_private_key_path" {}
variable "ec2_private_key_name" {}

variable "ec2_instances" {
  type = "map"

  default = {
    # Amazon-AMI
    "amazon-linux" = "ami-07683a44e80cd32c5"

    # RedHat-AMI
    "redhat-linux" = "ami-0e12cbde3e77cbb98"

    # Ubuntu-AMI
    "ubuntu-linux" = "ami-08d658f84a6d84a80"
  }
}

variable "ec2_content_archive_name" {
  default = "content.zip"
}

variable "vpc_address_space" {
  default = "10.1.0.0/16"
}

variable "tag_environment" {
  default = "ansible"
}

variable "s3_bucket_name" {
  default = "ansible-sourceo-bucket"
}
