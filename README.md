# Kickstart/Ansible proof of concept

This is a small proof of concept to perform an initial management of new installed CentOS nodes using Kickstart and Ansible.

#### Table of Contents
* [Ad hoc execution](#Ad-hoc-execution)
* [Automated playbook execution](#Automated-playbook-execution)

## Ad hoc execution
```shell
$ ansible -i staging all -m ping
$ ansible -i staging all -a "/bin/date"
$ ansible -i staging all -a "/bin/hostname"
$ ansible -i staging all -a "/bin/uptime"
$ ansible -i staging all -a "/bin/free -h"
$ ansible -i staging all -m shell -a "/bin/ps aux | /bin/grep chronyd"
$ ansible -i staging all -m yum -a "name=* state=latest"
$ ansible -i staging all -m setup
```

## Automated playbook execution
```shell
$ ansible-playbook -i staging site.yml
$ ansible-playbook -i staging playbooks/reboot_hosts.yml
```

## Directory layout (best practice)
```
production                # inventory file for production servers
staging                   # inventory file for staging environment

group_vars/
  all.yml                 # here we assign variables to all groups
  group1.yml              # here we assign variables to particular groups
  group2.yml
host_vars/
  hostname1.yml           # here we assign variables to particular systems
  hostname2.yml

library/                  # if any custom modules, put them here (optional)
module_utils/             # if any custom module_utils to support modules, put them here (optional)
filter_plugins/           # if any custom filter plugins, put them here (optional)

site.yml                  # master playbook
webservers.yml            # playbook for webserver tier
dbservers.yml             # playbook for dbserver tier

roles/
  common/                 # this hierarchy represents a "role"
    tasks/
      main.yml            #  <-- tasks file can include smaller files if warranted
    handlers/
      main.yml            #  <-- handlers file
    templates/            #  <-- files for use with the template resource
      ntp.conf.j2         #  <-- templates end in .j2
    files/
      bar.txt             #  <-- files for use with the copy resource
      foo.sh              #  <-- script files for use with the script resource
    vars/
      main.yml      #  <-- variables associated with this role
        defaults/         #
            main.yml      #  <-- default lower priority variables for this role
        meta/             #
            main.yml      #  <-- role dependencies
        library/          # roles can also include custom modules
        module_utils/     # roles can also include custom module_utils
        lookup_plugins/   # or other types of plugins, like lookup in this case

    webserver/            # same kind of structure as "common" was above, done for the webserver role
    dbserver/             # same kind of structure as "common" was above, done for the dbserver role
    fooapp/               # same kind of structure as "common" was above, done for the fooapp role
```
