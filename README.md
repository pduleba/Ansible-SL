# Ansible-SL

### Introduction
Ansible is an Automation tool. All examples are interacting with AWS EC2 instances.
Ansible consists of:
* `PlayBook` - text file of a set of tasks to be done (glue for `Inventory` and `Modules`)
* * `Play` - single task to be executed
* `Modules` - programmed unit of work to be done (actions --> goal)
* `Inventory` - text file describing your servers and systems
* * `categories` - way of grouping hosts
* `Ansible Config` - global configuration file
* * `override` - here *default* can be overridden
To execute Ansible you will need:
* `Python 2.6+`
* `Linux/Unix` - Windows is not supported by default
* `ssh` available (open) for incoming traffic on server(s) side
Variable types:
* `Host` - defined in Inventory per host or group
* `Facts` - data gathered from remote host
* `Dynamic` - data gathered by tasks or created at runtime

### Execution types
There are two execution types:
* `remote` - execution type flow looks like this:
* * CLIENT :: create package via `playbook` using `modules` for known servers in `inventory` with `config`
* * CLIENT :: send package via `ssh`
* * SERVER :: execute on remote using `remote ansible`
* * SERVER :: retrieve results in `JSON` format and sent to client 
* * CLIENT :: provide execution response details (successes and failures)
* `local` - used when remote system can't execute python package
* * CLIENT :: call via HTTP API (i.e. for webservice API calls)

### Overview
![Result](overview.PNG?raw=true "overview")

### Help
* [Ansible Documentation](https://docs.ansible.com/)
