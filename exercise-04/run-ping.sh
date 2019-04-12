#!/bin/bash
ansible all -i prod/inventory_prod -m ping --key-file ~/keys/LinuxIrelandKeyPair.pem