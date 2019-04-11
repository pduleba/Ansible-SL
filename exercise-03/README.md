# Exercise 03 - Variables and Inheritance

### Order of precedence
* `group_vars` all
* `group_vars` group_name (i.e. `ubuntu-servers`) override `all` 
* `hosts_vars` host_name (i.e. `ubuntu`) override group_name (i.e. `ubuntu-servers`)

### Commands
* `run-create-user.sh` - create user {{username}} using `all` variables 
* `run-create-user-using-group-override.sh` - create user {{username}} using `ubuntu-servers` variables (overrides `all` variables)
* `run-create-user-using-hosts.sh` - create user {{username}} using `ubuntu` variables (overrides `ubuntu-servers` variables)

### Help
* [Ansible Documentation](https://docs.ansible.com/)
