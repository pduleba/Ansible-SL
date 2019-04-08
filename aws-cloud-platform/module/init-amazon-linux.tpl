#!/bin/bash -xe
exec > >(tee /var/log/user-data.log|logger -t user-data -s 2>/dev/console) 2>&1
# update OS
yum update -y
# install Python2 + Python3
yum install -y python2 python2-pip
yum install -y python3 python3-pip
# install Ansible
pip3 install ansible --upgrade --user
# install AWS CLI
pip3 install awscli --upgrade --user
# update PATH
echo "export PATH=~/.local/bin:\$PATH"  >> ~/.bashrc
source ~/.bashrc
# download content.zip
aws s3 cp s3://ansible-sourceo-bucket/content.zip ~/content.zip
# change root prompt
echo "export PS1='\[\e[1;31m\][\u@amazon-linux \W]\$\[\e[0m\] '" >> ~/.bashrc