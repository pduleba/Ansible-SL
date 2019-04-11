#!/bin/bash
ansible all -i inventory -u ec2-user -m ping --key-file ~/keys/LinuxIrelandKeyPair.pem