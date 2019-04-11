#!/bin/bash
ansible all -i inventory -m ping --key-file ~/keys/LinuxIrelandKeyPair.pem