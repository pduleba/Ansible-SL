# Exercise 07 - Roles

### Idea
We are splitting `servers-playbook-advanced-features.yml` playbook from `Exercise-06` into re-usable pieces called roles.

### Examples
* `run-role-yum.sh` - Run `yum` role for servers in group `amazon` OR `redhat`
* `run-role-apt.sh` - Run `yum` role for servers in group `ubuntu`
* `run-role-all.sh` - Run `yum` role for servers in group `ubuntu` OR `amazon` OR `redhat` using
* * `common` role
* * `yum` role (imported as `*.yml` file)
* * `yum` role (imported as `*.yml` file)

### Help
* [Ansible Documentation](https://docs.ansible.com/)
