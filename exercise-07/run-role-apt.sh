#!/bin/bash
ansible-playbook -i inventory --key-file ~/keys/LinuxIrelandKeyPair.pem role-apt-playbook.yml