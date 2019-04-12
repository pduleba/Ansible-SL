# Exercise 04 - Configuration and Inheritance

### Configuration file order of precedence
* `$ANSIBLE_CONFIG` - variable overrides all below
* `./ansible.cfg` - file in current directory overrides all below
* * directory needs `400` permissions (`chmod`)
* `~/ansible.cfg` - file in `~/` directory overrides all below
* `/etc/ansible/ansible.cfg` - final way of overriding (created by `pip` only) 

### Configuration parameters overriding
Just create `ANSIBLE_` and name of configuration parameter (UPPER CASE). Here are some examples:
* `ANSIBLE_HOST_KEY_CHECKING` overrides `host_key_checking` configuration parameter
* `ANSIBLE_FORKS` overrides `forks` configuration parameter
* `ANSIBLE_LOG_PATH` overrides `log_path` configuration parameter

### Commands
Below command is based on `host_key_checking` (in file) and `ANSIBLE_HOST_KEY_CHECKING` variable.
Before running it clean `~/.ssh/known_hosts` file
* `run-ping.sh` - create user {{username}} using `all` variables 
* * when `host_key_checking` set to `False` it will **successed** (no check host in `~/.ssh/known_hosts`)
* * when `export ANSIBLE_HOST_KEY_CHECKING=True` it will **fail** (check host in `~/.ssh/known_hosts`)

### Help
* [Ansible Documentation](https://docs.ansible.com/)
