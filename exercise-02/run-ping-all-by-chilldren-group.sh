#!/bin/bash
ansible dbs -i inventory -m ping --key-file ~/keys/LinuxIrelandKeyPair.pem