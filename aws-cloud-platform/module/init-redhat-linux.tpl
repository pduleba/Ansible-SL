#!/bin/bash -xe
exec > >(tee /var/log/user-data.log|logger -t user-data -s 2>/dev/console) 2>&1
yum -y update
curl "https://bootstrap.pypa.io/get-pip.py" -o "get-pip.py"
sudo python get-pip.py
sudo pip install awscli
aws s3 cp s3://ansible-sourceo-bucket/content.zip ~/content.zip
echo export "PS1='\[\e[1;31m\][\u@redhat-linux \W]\$\[\e[0m\] '" >> ~/.bashrc