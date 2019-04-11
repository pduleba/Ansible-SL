#!/bin/bash -xe
exec > >(tee /var/log/user-data.log|logger -t user-data -s 2>/dev/console) 2>&1
# update OS
yum update -y
# install Python2 + Python3
yum install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
yum install -y https://centos7.iuscommunity.org/ius-release.rpm
yum install -y python2-pip
yum install -y python36u python36u-pip
ln -sfn /bin/python3.6 /usr/sbin/python3
ln -sfn /bin/pip3.6 /usr/sbin/pip3
# install Ansible
pip3 install ansible --upgrade
# install AWS CLI
pip3 install awscli --upgrade
# Enable Command Completion
echo "complete -C '/usr/bin/aws_completer' aws" >> ~/.bashrc
echo "complete -C '/usr/bin/aws_completer' aws" >> /home/ec2-user/.bashrc
# download content.zip
aws s3 cp s3://ansible-sourceo-bucket/content.zip ~/content.zip
# change root prompt
echo "export PS1='\[\e[1;31m\]\u@\h\[\e[0m\]:\[\e[1;34m\]\W\[\e[0m\]$\[\e[0m\] '" >> ~/.bashrc
echo "export PS1='\[\e[1;32m\]\u@\h\[\e[0m\]:\[\e[1;34m\]\W\[\e[0m\]$\[\e[0m\] '" >> /home/ec2-user/.bashrc