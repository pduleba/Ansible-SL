#!/bin/bash
ansible 34.245.64.12 -i inventory -u ec2-user -m ping --key-file ~/keys/LinuxIrelandKeyPair.pem