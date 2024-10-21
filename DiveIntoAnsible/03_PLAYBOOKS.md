# PLAYBOOKS

- ### Playbook Example:
- `motd_playbook.yaml`
    ```
    ---
    # YAML documents begin with the document separator ---

    # The minus in YAML this indicates a list item.  The playbook contains a list 
    # of plays, with each play being a dictionary
    -
    
    # Hosts: where our play will run and options it will run with
    hosts: centos
    user: root

    # Vars: variables that will apply to the play, on all target systems

    # Tasks: the list of tasks that will be executed within the playbook
    tasks:
        - name: Configure a MOTD (message of the day)
        copy:
            src: centos_motd
            dest: /etc/motd

    # Handlers: the list of handlers that are executed as a notify key from a task

    # Roles: list of roles to be imported into the play

    # Three dots indicate the end of a YAML document
    ...
    ```

    execution - `ansible-playbook motd_playbook.yaml`

- ### Additional Configurations / Options
    - `gather_facts: False` - Will turn off the facts gathering from the machines (can speedup the process of execution when we dont need the facts)

    - You can create a file with the content if it does not exist.
        ```
        tasks:
            - name: Configure a MOTD (message of the day)
            copy:
                content: Welcome to CentOS Linux - Bugz
                dest: /etc/motd
        ```
    - Using vars inside palybook
        ```
        vars:
            motd: "Welcome to CentOS Linux - Bugz"
        tasks:
            - name: Configure a MOTD (message of the day)
            copy:
                content: "{{ motd }}"
                dest: /etc/motd
        ```

    7 In Ansible, `mode: preserve` is an option used with the `copy` or `template` modules to maintain the file's existing permissions during the copy operation.

- ### More commands
    - `time ansible-playbook ....` - `time` will show the execution time of a playbook.

- ### Handlers
    Handlers are executed when called by notification, note how `notify` in `tasks` is calling `MOTD Changed` handler.

    ```
    ---
    -
    hosts: centos
    user: root
    gather_facts: False

    vars:
        motd: "Welcome to CentOS Linux - Ansible Rocks\n"

    tasks:
        - name: Configure a MOTD (message of the day)
        copy:
            content: "{{ motd }}"
            dest: /etc/motd
        notify: MOTD changed

    # Handlers: the list of handlers that are executed as a notify key from a task
    handlers:
        - name: MOTD changed
        debug:
            msg: The MOTD was changed
    ...

    ```

    In the example below, we will targed only linux `hosts`, and we will use `when` to decide what action in the `tasks` to do, depending in the distro of the `ansible_distribution` which is collected during `setup`
    ```
    ---
    -
    hosts: linux
    
    vars:
        motd_centos: "Welcome to CentOS Linux - Ansible Rocks\n"
        motd_ubuntu: "Welcome to Ubuntu Linux - Ansible Rocks\n"
    
    tasks:
        - name: Configure a MOTD (message of the day)
        copy:
            content: "{{ motd_centos }}"
            dest: /etc/motd
        notify: MOTD changed
        when: ansible_distribution == "CentOS"

        - name: Configure a MOTD (message of the day)
        copy:
            content: "{{ motd_ubuntu }}"
            dest: /etc/motd
        notify: MOTD changed
        when: ansible_distribution == "Ubuntu"
    
    handlers:
        - name: MOTD changed
        debug:
            msg: The MOTD was changed
    ...
    ```