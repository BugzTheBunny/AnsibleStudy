# Modules

- In this section we use `centos1` for examples.

- ## `Setup` module
    The setup module in Ansible is used to gather system information (known as "facts") from remote hosts. These facts include details about the operating system, network interfaces, hardware architecture, and more. This information is crucial for making informed decisions within your playbooks.

    - `Fact Gathering`: By default, Ansible runs the setup module at the beginning of each play to collect facts about the target hosts.

    - `Usage in Playbooks`: The collected facts are stored as variables, which you can use in your playbooks for conditionals, templating, and other dynamic functionalities.

    - `Ad-Hoc Commands`: You can manually run the setup module using an ad-hoc command to display the facts collected from hosts.

    #### Uage 
    - `ansible centos1 -m setup`
    - `ansible centos -m setup | more`

- ## `File` module
    The file module in Ansible is used to manage file and directory properties on remote hosts. It allows you to create, delete, and modify files and directories, set permissions, ownership, and manage symbolic or hard links. This module is essential for tasks involving file system management during automation.

    - `File and Directory Management`: Create or remove files and directories.
    - `Permissions and Ownership`: Set file or directory permissions (mode), ownership (owner and group).
    - `Symbolic and Hard Links`: Create or remove symbolic (state: link) or hard links (state: hard).
    `Idempotent Operations`: Ensures tasks only make changes when necessary, maintaining the desired state without redundant actions.

    #### Usage
    - `ansible all -m file -a 'path=/tmp/test state=touch` - Will create `test` file on all hosts.

- ## `Ansible Colors`
    - `Red` - Failure
    - `Yellow` - Success, with Changes
    - `Green` = Sucess, no Changes

- ## Unix Permissions
    #### Usage 
    Settings the test file to permission 600
    -`ansible all -m file -a 'path=/tmp/test state=file mode=600'`
- ## Idempotency
    - An operation is idempotent, if the result of performing it once, is exactly the same as the result of performing it repeatedly without intervening actions.
    - ansible actions should be idempotent.
- ## `Copy` module
    #### Usage
    - `ansible all -m copy -a 'src=/tmp/x dest=/tmp/x'` - This will copy file `x` from localhost to all hosts, the localhost will show `green`, as it's already in the endstate, all the others will have `yellow`
    - `ansible all -m copy -a 'remote_src=yes src=/tmp/x dest=tmp/y'` - This will allow also to copy things on the remote itself, meaning the `x` will be copied on the remote into `y`

- ## `Command` module
    `Note` - the `command` module does not take variables and operations like a shell does, meaning `$HOME`, <, >, | etc. will not work there, use the `Shell` module instead if you need these features.
    #### Usage