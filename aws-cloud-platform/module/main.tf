##################################################################################
# PROVIDERS
##################################################################################

provider "aws" {
  access_key = "${var.aws_access_key}"
  secret_key = "${var.aws_secret_key}"
  region     = "${var.aws_region}"
}

##################################################################################
# LOCALS
##################################################################################

locals {
  common_tags = {
    Environment = "${var.tag_environment}"
  }
}

##################################################################################
# DATA
##################################################################################

data "aws_availability_zones" "available-az" {}

data "archive_file" "zip" {
  type        = "zip"
  output_path = "${path.module}/out/${var.ec2_content_archive_name}"
  source_dir  = "${path.module}/resources"
}

data "http" "ip-http" {
  url = "http://ipv4.icanhazip.com"
}

// NEW way of defining policy (see `aws_iam_role` for OLD example)
data "aws_iam_policy_document" "s3readobjectonly-policy-document" {
  version = "2012-10-17"

  statement {
    sid       = "VisualEditor0"
    effect    = "Allow"
    actions   = ["s3:getObject"]
    resources = ["arn:aws:s3:::${var.s3_bucket_name}/*"]
  }
}

data "template_file" "init-amazon-linux" {
  template = "${file("${path.module}/init-amazon-linux.tpl")}"
}

data "template_file" "init-redhat-linux" {
  template = "${file("${path.module}/init-redhat-linux.tpl")}"
}

data "template_file" "init-ubuntu-linux" {
  template = "${file("${path.module}/init-ubuntu-linux.tpl")}"
}

##################################################################################
# RESOURCES
##################################################################################

# NETWORKING #
module "vpc" {
  source = "modules/vpc"
  name   = "${var.tag_environment}-vpc"

  cidr = "${var.vpc_address_space}"
  azs  = "${data.aws_availability_zones.available-az.names}"

  tags = "${merge(local.common_tags, map("Name", format("%s-VPC", var.tag_environment)))}"
}

# Web security group
resource "aws_security_group" "instance-sg" {
  name   = "instance-sg"
  vpc_id = "${module.vpc.vpc_id}"

  # SSH access from anywhere
  ingress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"

    # allow access for My IP only
    cidr_blocks = ["${chomp(data.http.ip-http.body)}/32"]
  }

  # HTTP access from the VPC
  ingress {
    from_port = 80
    to_port   = 80
    protocol  = "tcp"

    # allow access for My IP only
    cidr_blocks = ["${chomp(data.http.ip-http.body)}/32"]
  }

  # outbound internet access
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = "${merge(local.common_tags, map("Name", format("%s-SG", var.tag_environment)))}"
}

# IAM Role
resource "aws_iam_role" "ec2tos3access-role" {
  name = "ec2tos3access-role"

  // This is `Trust Relationship` console equivalent
  // OLD way of defining policy (see data for new way)
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF

  tags = "${merge(local.common_tags, map("Name", format("%s-Role", var.tag_environment)))}"
}

# IAM Policy
resource "aws_iam_policy" "s3readobjectonly-policy" {
  name   = "s3readobjectonly-policy"
  policy = "${data.aws_iam_policy_document.s3readobjectonly-policy-document.json}"
}

# Attach Policy To Role
resource "aws_iam_role_policy_attachment" "attachs3policytos3role" {
  role       = "${aws_iam_role.ec2tos3access-role.name}"
  policy_arn = "${aws_iam_policy.s3readobjectonly-policy.arn}"
}

# Instance Profile (EC2 'IAM Role' equivalent)
resource "aws_iam_instance_profile" "ec2ToS3-instance-profile" {
  name = "instance-profile"
  role = "${aws_iam_role.ec2tos3access-role.name}"
}

# Instances - Amazon Linux #
resource "aws_instance" "amazon-linux" {
  ami                    = "${lookup(var.ec2_instances, "amazon-linux")}"
  instance_type          = "t2.micro"
  key_name               = "${var.ec2_private_key_name}"

  subnet_id              = "${element(module.vpc.public_subnets, 0)}"
  vpc_security_group_ids = ["${aws_security_group.instance-sg.id}"]

  iam_instance_profile   = "${aws_iam_instance_profile.ec2ToS3-instance-profile.name}"
  user_data              = "${data.template_file.init-amazon-linux.template}"

  tags                   = "${merge(local.common_tags, map("Name", format("%s-amazon-linux", var.tag_environment)))}"
}

# Instances - Redhat Linux #
resource "aws_instance" "redhat-linux" {
  ami                    = "${lookup(var.ec2_instances, "redhat-linux")}"
  instance_type          = "t2.micro"
  key_name               = "${var.ec2_private_key_name}"

  subnet_id              = "${element(module.vpc.public_subnets, 1)}"
  vpc_security_group_ids = ["${aws_security_group.instance-sg.id}"]

  iam_instance_profile   = "${aws_iam_instance_profile.ec2ToS3-instance-profile.name}"
  user_data              = "${data.template_file.init-redhat-linux.template}"

  tags                   = "${merge(local.common_tags, map("Name", format("%s-redhat-linux", var.tag_environment)))}"
}

# Instances - Ubuntu Linux #
resource "aws_instance" "ubuntu-linux" {
  ami                    = "${lookup(var.ec2_instances, "ubuntu-linux")}"
  instance_type          = "t2.micro"
  key_name               = "${var.ec2_private_key_name}"

  subnet_id              = "${element(module.vpc.public_subnets, 2)}"
  vpc_security_group_ids = ["${aws_security_group.instance-sg.id}"]

  iam_instance_profile   = "${aws_iam_instance_profile.ec2ToS3-instance-profile.name}"
  user_data              = "${data.template_file.init-ubuntu-linux.template}"

  tags                   = "${merge(local.common_tags, map("Name", format("%s-ubuntu-linux", var.tag_environment)))}"
}

# S3 Bucket config#
module "bucket" {
  source = "modules/s3"
  name   = "${var.s3_bucket_name}"

  tags = "${merge(local.common_tags, map("Name", format("%s-instance-bucket", var.tag_environment)))}"
}

resource "aws_s3_bucket_object" "zipcontent-s3-object" {
  bucket = "${module.bucket.bucket}"
  key    = "/${var.ec2_content_archive_name}"
  source = "./out/${var.ec2_content_archive_name}"
}
