#!/bin/bash
ansible amazon -i inventory -m yum -a "name=httpd state=present" --key-file ~/keys/LinuxIrelandKeyPair.pem --sudo