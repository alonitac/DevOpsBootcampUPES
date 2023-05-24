# Ansible

Ansible is an open-source automation tool that simplifies the process of configuring and managing remote servers.

- Declarative language described in YAMLs.
- Automate repetitive tasks such as software installation, configuration management, and application deployment across multiple servers or workstations
- Works over SSH, allowing it to manage both Linux and Windows machines.
- Large and active community
- Ships with an [extensible documentation](https://docs.ansible.com/ansible/latest/getting_started/index.html#getting-started-with-ansible). 

## Installation


https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html#installing-ansible

**Note**: While Ansible as a tool can connect and manage remote Windows servers, installing and using Ansible **from** Windows is not supported, only Linux here. 

## Choosing the right tool (Terraform vs Ansible)

![](img/ansible_tf.png)

## Build simple inventory and use ad-hoc commands

Ansible works against multiple managed nodes or “hosts” in your infrastructure at the same time, using a list or group of lists known as [inventory](https://docs.ansible.com/ansible/latest/inventory_guide/intro_inventory.html).
The default location for inventory is a file called `/etc/ansible/hosts` (use `-i` to specify another location).

An ad-hoc command is a single, one-time command that you run against your inventory (or a single host), without the need for a playbook.
Ad-hoc commands are useful for performing quick and simple tasks, such as checking the uptime of a server or installing a package.

1. In this demo we will use two **Amazon Linux** EC2 instances as the server inventory. Make sure you have access to the `.pem` private key.
2. Create a simple `hosts` inventory file as follows:
```ini
<host-ip1>
<host-ip2>
```

An Ansible ad hoc command uses the `ansible` command-line tool to automate a single task. We will use the [`ping` module](https://docs.ansible.com/ansible/latest/collections/ansible/builtin/ping_module.html) to ping our hosts.

3. Run the following command, investigate the returned error and use the `--user` option to fix it.
```shell
ansible -i /path/to/inventory-file --private-key /path/to/private-key-pem-file all -m ping
```

4. Let's say the hosts run webserver, we can arrange hosts under groups, and automate tasks for specific group:
```ini
[webserver]
web1 ansible_host=<host-ip-1> ansible_user=<host-ssh-user>
web2 ansible_host=<host-ip-2> ansible_user=<host-ssh-user>
```

There are two more default groups: `all` and `ungrouped`. The all group contains every host. The ungrouped group contains all hosts that don't have another group aside from `all`.

5. Let's check the uptime of all server in `webserver` group:
```shell
ansible -i /path/to/inventory-file --private-key /path/to/private-key-pem-file webserver -m command -a "uptime"
```

## Working with Playbooks

If you need to execute a task with Ansible more than once, write a **playbook** and put it under source control.
Ansible Playbooks offer a repeatable, re-usable and simple configuration management.
Playbooks are expressed in YAML format, composed of one or more ‘plays' in an **ordered** list.
A playbook 'play' runs one or more tasks. Each task calls an Ansible module from top to bottom.

In this demo, we will be practicing some security hardening for the webserver hosts.

To demonstrate the power of Ansible, we first want to create a task that verify the installation of `httpd` (and install it if needed).

1. Create the following `site.yaml` file, representing an Ansible playbook:
```yaml
---
- name: Harden web servers
  hosts: <hosts-group>
  tasks:
    - name: Ensure httpd is at the latest version
      ansible.builtin.yum:
        name: httpd-2.4*
        state: latest
```

In the above example, [`ansible.builtin.yum`](https://docs.ansible.com/ansible/latest/modules/yum_module.html#yum-module) is the module being used, `name` and `state` are module's parameters. 
In Ansible, a module is a small piece of code that is used to perform specific tasks, such as managing packages, files, or services on a target system.
Ansible ships with hundreds of [built-in modules](https://docs.ansible.com/ansible/latest/modules/list_of_all_modules.html) available for usage.

2. Apply your playbook using the following `ansible-playbook` command.
```shell
ansible-playbook -i /path/to/inventory-file --private-key /path/to/private-key-pem-file site.yaml
```

As the tasks in this playbook require root-privileges, we add the `become: yes` to enable execute tasks as a different Linux user, as well as [using variables](https://docs.ansible.com/ansible/latest/playbook_guide/playbooks_variables.html#using-variables):
```yaml
---
- name: Harden web servers
  hosts: webserver
  become: yes
  become_method: sudo
  vars:
    apache_version: 2.4  
  vars_files:
    - vars/amazon_linux_ssh_vars.yaml  # this file will be discussed soon...
  tasks:
    - name: Ensure httpd is at the latest version
      become_user: root
      ansible.builtin.yum:
        name: "httpd-{{ apache_version }}*"
        state: latest
```
Run the playbook again and make sure the task has been completed successfully.

We now want to harden the SSH configurations of the hosts.

3. Add the following task to your playbook:
```yaml
  tasks:
    # ...

    - name: Write the sshd config file
      ansible.builtin.template:
        src: templates/sshd_config.j2
        dest: /etc/ssh/sshd_config
```

Ansible uses [Jinja2](https://jinja.palletsprojects.com/en/3.1.x/) templating mechanism to enable dynamic expressions and access to [variables](https://docs.ansible.com/ansible/latest/user_guide/playbooks_variables.html#playbooks-variables).
The `templates/sshd_config.j2` and its corresponding variable file `vars/amazon_linux_ssh_vars.yaml` can be found in our shared repo.

5. Run the playbook. Connect to one of the hosts and make sure the `sshd` configuration file has been updated.
6. For the new SSH configs to be applied, it's required to restart the `sshd` service. Let's add a `handlers:` entry with a handler that restarts the daemon after a successful configuration change:
```yaml
---
- name: Harden web servers
  # ...

  tasks:
    # ...

  handlers:
    - name: restart sshd
      become_user: root
      ansible.builtin.service:
        name: sshd
        state: restarted

```
Note that in order to trigger the handles, the **Write the sshd config file** tasks needs to notify the **restart sshd** handler. [Read how to do it](https://docs.ansible.com/ansible/latest/playbook_guide/playbooks_handlers.html#handlers).

7. Run the playbook and check the status of the `sshd` service by running `sudo systemctl status sshd` in one of the hosts machine.
8. Now, in the YAML variables file, change the `sshd_port` variable to a number other than `22` and run the playbook.
9. You will need update your `hosts` inventory file to use the new port, as follows:
```ini
web1 ansible_host=... ansible_user=... ansible_port=23
```

Make sure Ansible is able to communicate with your hosts after the change.

### Validating playbook tasks: `check` mode and `diff` mode

Ansible provides two modes of execution that validate tasks: check mode and diff mode.
They are useful when you are creating or editing a playbook, and you want to know what it will do.

In `check` mode, Ansible runs without making any changes on remote systems, and report the changes that would have made.
In `diff` mode, Ansible provides before-and-after comparisons.

Simply add the `--check` or `--diff` options (both or separated) to the `ansible-playbook` command:

```shell
ansible-playbook -i ./inventory/hosts site.yaml --check --diff 
```

## Ansible Facts

You can retrieve or discover certain variables containing information about your remote systems, which are called **facts**.
For example, with facts variables you can use the IP address of one system as a configuration value on another system. 
Or you can perform tasks based on the specific host OS.

To see all available facts, add this task to a play:

```yaml
    tasks:
      # ...
    - name: Print all available facts
      ansible.builtin.debug:
        var: ansible_facts
```

Or alternatively, run the `-m setup` ad-hoc command:
```shell
ansible -i ./inventory/hosts webserver -m setup
```

As the `ansible.builtin.yum` module fits only RedHat family systems (e.g. Amazon Linux), we would like to add a condition for tasks using the yum built-in module, using the `ansible_pkg_mgr` facts variable:

```yaml
    tasks:
    # ...
    - name: Ensure httpd is at the latest version
      become_user: root
      ansible.builtin.yum:
        name: httpd-2.4*
        state: latest
      when: ansible_facts['pkg_mgr'] == 'yum'
```

### Try it yourself

1. Create another task to make sure that the latest version of `auditd` daemon is installed. In order to do it manually, without ansible, we do `sudo yum install audit`.
2. Add some rules to the `auditd` daemon. The config template in located under `17_ansible_workdir/templates/auditd_rules.j2`, while path in the server to which you need to apply the configurations is `/etc/audit/rules.d/audit.rules`. 

You'll apply two auditing rules: 

- Audit all activities in `/root` directory.
- Audit `sudo` usage.

3. Add a handler to restart the `auditd` daemon. 

4. Test that the auditing rules were applied:
   1. Execute some command as root: `sudo su -`
   2. Search for appropriate audit logs: `sudo ausearch -k using_sudo`.

## Organize the playbook using Roles

[Roles](https://docs.ansible.com/ansible/latest/user_guide/playbooks_reuse_roles.html) are collection of tasks, files, templates, variables and other Ansible artifacts that are organized in a structured way to perform a specific function.
Roles are used to create reusable and modular code, making it easier to manage complex configurations and deployments.

Collections are a distribution format for Ansible content that can include playbooks, roles, modules, and plugins. You can install and use collections through a distribution server, such as [Ansible Galaxy](https://galaxy.ansible.com). 

1. Redesign your YAML files according to the following files structure:
```text
#  in the working directory of your Ansible playbook
roles/
    sshd/
        tasks/
            main.yaml
        handlers/
            main.yaml
        templates/
            sshd_config.j2
        vars/
            main.yaml
     auditd/
        tasks/
            main.yaml
        handlers/
            main.yaml
        templates/
            auditd_rules.j2
        vars/
            main.yaml      
```

By default, Ansible will look in each directory within a role for a `main.yaml` file for relevant content.

2. Create a `site.yaml` file with the following content:
```yaml
---
- name: Harden web servers
  hosts: webserver
  become: yes
  become_method: sudo
  roles:
    - sshd
    - auditd
  tasks:
    # ...

```

Ansible will execute roles first, then other tasks in the play.

In the context of the content we've covered - system hardening, you can take a look on the [devsec.hardening](https://galaxy.ansible.com/devsec/hardening) collection. 

