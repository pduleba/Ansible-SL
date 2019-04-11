#!/bin/bash
# create user {{username}} with password using `user` module on `ubuntu-servers` group with `sudo` permissions
ansible ubuntu-servers -i inventory_dev -m user -a "name={{username}} password=12345" --key-file ~/keys/LinuxIrelandKeyPair.pem --sudo