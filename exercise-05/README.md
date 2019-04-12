# Exercise 05 - Modules

### Resource filtering
* `ansible servers:ubuntu -i inventory -m setup` - run for all servers located in `servers` **OR** `ubuntu` groups ONLY
* `ansible servers:&ubuntu -i inventory -m setup` - run for all servers located in `servers` **AND** `ubuntu` groups ONLY (inner join)
* `ansible !ubuntu -i inventory -m setup` - run for servers all located **NOT** `ubuntu` group
* `ansible ~u[0-5]+ -i inventory -m setup` - run for servers all located group with name matching to `~u[0-5]+` regex
* * `servers:&ubuntu:!redhat` - run for servers in both `servers` **AND** `ubuntu` but **NOT IN** `redhat`

### Module manual
* `ansible-doc -l` - list available modules 
* `ansible-doc ping` - list documentation of `ping` module
* * required parameters starts with `=`
* `ansible-doc user` - list documentation of `user` module
* * required parameters starts with `=`
* `ansible-doc -s ping` - show playbook snipped of of `ping` module
* `ansible-doc -s user` - show playbook snipped of of `user` module

### Inventory details 
* `ansible ubuntu -i inventory -m setup --key-file ~/keys/LinuxIrelandKeyPair.pem -a "filter=ansible_mounts"` - show details of `ubuntu` item with `filtering`

### Usage example
* `run-install-httpd.sh` - install httpd on `amazon` group using `yum` module
* `run-start-httpd.sh` - start httpd on `amazon` group using `service` module

### Help
* [Ansible Documentation](https://docs.ansible.com/)
