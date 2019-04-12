# Exercise 05 - Playbook

### Idea
* `Playbook` contains plays
* `Play` contains tasks for hosts

### Examples
Each `playbook` **requires** whitespace proper indention (` `).
* `run-playbook.yml` - runs 3 plays (`amazon`, `redhat` and `ubuntu`)
* * use `--limit @./playbooks/servers-playbook.retry` parameters to re-try failures
* `run-playbook-advanced.sh` - demonstrates advanced features of Ansible (see *.yaml for details)

### Help
* [Ansible Documentation](https://docs.ansible.com/)
