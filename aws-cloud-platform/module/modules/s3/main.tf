variable "name" {}

variable "tags" {
  type    = "map"
  default = {}
}

resource "aws_s3_bucket" "bucket" {
  bucket        = "${var.name}"
  acl           = "private"
  force_destroy = "true"

  tags = "${merge(var.tags, map("Name", format("%s-web-bucket", var.name)))}"
}

output "bucket" {
  value = "${aws_s3_bucket.bucket.bucket}"
}

output "bucket_id" {
  value = "${aws_s3_bucket.bucket.id}"
}
