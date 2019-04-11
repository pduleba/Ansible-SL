#!/bin/bash
ansible servers -i inventory -m ping --key-file ~/keys/LinuxIrelandKeyPair.pem