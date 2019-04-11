#!/bin/bash
ansible yum-servers -i inventory -m ping --key-file ~/keys/LinuxIrelandKeyPair.pem