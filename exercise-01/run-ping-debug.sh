#!/bin/bash
ansible 34.245.64.12 -i inventory -u ec2-user -m ping -vvv --key-file ~/keys/LinuxIrelandKeyPair.pem