#!/bin/bash
ansible-playbook -i inventory --key-file ~/keys/LinuxIrelandKeyPair.pem playbooks/servers-playbook.yml