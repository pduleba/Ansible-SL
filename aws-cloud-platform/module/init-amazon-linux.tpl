#!/bin/bash -xe
exec > >(tee /var/log/user-data.log|logger -t user-data -s 2>/dev/console) 2>&1
yum -y update
aws s3 cp s3://ansible-sourceo-bucket/content.zip ~/content.zip
echo export "PS1='\[\e[1;31m\][\u@amazon-linux \W]\$\[\e[0m\] '" >> ~/.bashrc