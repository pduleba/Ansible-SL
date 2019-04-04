##################################################################################
# OUTPUT
##################################################################################

output "Amazon-Linux" {
  value = "${aws_instance.amazon-linux.public_ip}"
}

output "Redhat-Linux" {
  value = "${aws_instance.redhat-linux.public_ip}"
}

output "Ubuntu-Linux" {
  value = "${aws_instance.ubuntu-linux.public_ip}"
}
