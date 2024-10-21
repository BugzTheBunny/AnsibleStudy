
# Commands for usage.

- `docker-compose up` -> opens a lab on localhost:1000
- `sudo apt update` -> `sudo apt install sshpass`

- generate ssh keys for all instances:
```
for user in ansible root
do
    for os in ubuntu centos
        do     
            for instance in 1 2 3
                do
                    sshpass -f password.txt ssh-copy-id -o StrictHostKeyChecking=no ${user}@${os}${instance}
                done
        done;
done
```

- pings all of the instances using ansible`ansible -i,ubuntu1,ubuntu2,ubuntu3,centos1,centos2,centos3 all -m ping`kl 
- connect to an instance `ssh ansible@{remote}` - example - `shh ansible@centos2`
- to configure `centos1` ports, ssh into it, go to `/utils` and run `update_sshd_ports.sh 22 2222`


# Info

### Configuration
#### Priority of configurations

- `Lowest` Typicaly the configuration is located under `/etc/ansible/ansible.cfg`

- `~/.ansible.cfg` - A hidden file, inside of the users home directory

- `./ansible.cfg` - A hidden file in the current directory.

- `ANSIBLE_CONFIG` - an environmental variable that targets a config file.

### Inventory Options (Section 3, part 10)
- `hosts` file - They are all added to the `all` group.
    ```
    [centos]
    centos1
    centos2
    centos3

    [ubuntu]
    ubuntu1
    ubuntu2
    ubuntu3
    ```
    View groups - `ansible-inventory --list`:
    ```
    {
        "_meta": {
            "hostvars": {}
        },
        "all": {
            "children": [
                "ungrouped",
                "centos",
                "ubuntu"
            ]
        },
        "centos": {
            "hosts": [
                "centos1",
                "centos2",
                "centos3"
            ]
        },
        "ubuntu": {
            "hosts": [
                "ubuntu1",
                "ubuntu2",
                "ubuntu3"
            ]
        }
    }
    ```

- ### (01) `ANSIBLE_HOST_KEY_CHECKING=False ansible all -m ping`:  
     This will make ansible to ignore the host key check, but we don't want to write it eveytime manually, this will also recreate the `known_hosts` file
- ### (02) Instead if the command above, we can add :
    ```
    [defaults]
    inventory = hosts
    host_key_checking = False <-
    ```
- ### (03) You can ping now using these commands:
    - #### Pinging
        - `ansible all -m ping` - will ping all
        - `ansible centos -m ping` - will ping centos
        - `ansible ubuntu -m ping` - willping ubuntu
    - ####  More pinging
        - `ansible all -m ping -o` - A condenced view 
        - `ansible centos1 -m ping` - Will ping a single host
    - #### List hosts in a group:
        - `ansible centos --list-hosts`
        - `ansible ubuntu --list-hosts`
        - `ansible all --list-hosts`
        - `ansible ~.*3 --list-hosts` - Listing hosts using regex, everything ending with 3

- ### (04) SSH With user:
    `ansible_user=root` - this is tating that the user we want to use, is `root`.
    ```
    [centos]
    centos1 ansible_user=root
    centos2 ansible_user=root
    centos3 ansible_user=root
    ```
    - `ansible all -n command -a 'id' -o` - This will run the `id` command on the hosts
        
- ### (05) It's not a good parcite to login directly into the root, so use a different method:
    ```
    [ubuntu]
    ubuntu1 assible_become=true ansible_become_pass=password
    ubuntu2 assible_become=true ansible_become_pass=password
    ubuntu3 assible_become=true ansible_become_pass=password
    ```
    - This way, we firt access as `ansible` and then change to `root`
    - `ansible_become` will make ansible to become the root user user, `ansible_become_pass` is the password of the root.
    - The `command` module, is the default ansible module, so it is used by default, so you can use - `ansible all -a 'id' -o`

- ### (06 + 07) Specify a port / connect to a port
    Sometimes we want to connect to a different port, let's say the SSHD on centos1 runs on port 2222, we edit it like this: `ansible_port=2222`
    ```
    [centos]
    centos1 ansible_user=root ansible_port=2222
    ```
    You can also specify it like this:
    ```
    [centos]
    centos1:2222 ansible_user=root
    ```
- ### (08) control group
    ```
    [control]
    ubuntu-c ansible_connection=local
    ```
    We will add this, to also add the localhost to the hosts list to execute on it.
- ### (09) range of hosts
    You can also specify the hosts using a range, for example below.
    ```
    [control]
    ubuntu-c ansible_connection=local

    [centos]
    centos1:2222 ansible_user=root
    centos[2:3] ansible_user=root

    [ubuntu]
    ubuntu[1:3] assible_become=true ansible_become_pass=password
    ```
- ### (10) more specific config, withot the need to specify on every host
    ```
    [control]
    ubuntu-c ansible_connection=local

    [centos]
    centos1:2222
    centos[2:3]

    [centos:vars] - specifies the variables for `centos`
    ansible_user=root

    [ubuntu]
    ubuntu[1:3]

    [ubuntu:vars] - specifies the variables for `ubuntu`
    ansible_become=true
    ansible_become_pass=password
    ```
- ### (11) Collections - parent declaration
    We decalared a group, under the name of `linux`
    ```
    [control]
    ..
    [ubuntu:vars]
    ..
    [linux:children] 
    centos
    ubuntu
    ```
    - `ansible linux -m ping -o` - Now you can use the group.
- ### (12) - using `all`
    We can use the `all` group to set variables to all of the hosts
    ```
    [all]
    ansible_port=1234
    ```
    Notice, that a specific specied port/config, for example the port on centos1 (the 2222 port) will take priority, over the `all` configurations.  
    * Note that the sshd is running on port 22, so `1234` is an invalid configuration 
- ### (13) variables to groups
    We can also apply variables to groups
    ```
    [linux:vars]
    ansible_port=1234
    ```
- ### (14) the configuration can be specified in `JSON` / `YAML` / `ini` formats:
    - `hosts.yaml`
    ```
    ---
    contol:
    hosts:
        ubuntu-c:
        ansible_connection: local
    centos:
    hosts:
        centos1:
        ansible_port: 2222
        centos2:
        centos3:
    vars:
        ansible_user: root
    ubuntu:
    hosts: 
        ubuntu1:
        ubuntu2:
        ubuntu3:
    vars:
        ansible_become: true
        ansible_become_pass: password
    linux:
    children:
        centos:
        ubuntu:
    ...
    ```
- ### (15) Convert `YAML` into `JSON` config
    ```
    python3 -c 'import sys, yaml, json; json.dump(yaml.load(sys.stdin, Loader=yaml.FullLoader), sys.stdout, indent=4)' < hosts.yaml > hosts.json
    ```
- ### (16) `-e`
    You can send an extra variable using `-e` when runnig commands.
    - `ansible linux -m ping -e 'ansible_port=22' -o` - everything will work, besides `centos1`, because we force it to use port 22, and not 2222