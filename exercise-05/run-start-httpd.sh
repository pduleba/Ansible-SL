#!/bin/bash
ansible amazon -i inventory -m service -a "name=httpd enabled=yes state=started" --key-file ~/keys/LinuxIrelandKeyPair.pem --sudo