# More Modules.

- `set_fact` - allows us to set facts on the go.
    - Example: 
        ```
        ---
        -
        hosts: ubuntu3,centos3
        tasks:
            - name: Set a fact
            set_fact:
                our_fact: Ansible Rocks!

            - name: Show custom fact
            debug:
                msg: "{{ our_fact }}"
        ...
        ```
    - Example 2 : We can also set multiple facts in one time, or overwrite existing facts:
        ```
        ---
        -
        hosts: ubuntu3,centos3
        tasks:
            - name: Set a fact
            set_fact:
                our_fact: Ansible Rocks!
                ansible_distribution: "{{ ansible_distribution | upper }}"

            - name: Show our_fact
            debug:
                msg: "{{ our_fact }}"

            - name: Show ansible_distribution
            debug:
                msg: "{{ ansible_distribution }}"
        ...
        ``` 
    - Example 3 : A more advanced example, where we set facts, depending on the system
        ```
        ---
        -
            hosts: ubuntu3,centos3
            tasks:
                - name: Set our installation variables for CentOS
                set_fact:
                    webserver_application_port: 80
                    webserver_application_path: /usr/share/nginx/html
                    webserver_application_user: root
                when: ansible_distribution == 'CentOS'

                - name: Set our installation variables for Ubuntu
                set_fact:
                    webserver_application_port: 8080
                    webserver_application_path: /var/www/html
                    webserver_application_user: nginx
                when: ansible_distribution == 'Ubuntu'

                - name: Show pre-set distribution based facts
                debug:
                    msg: "webserver_application_port:{{ webserver_application_port }} webserver_application_path:{{ webserver_application_path }} webserver_application_user:{{ webserver_application_user }}"
        ...

        ```

- `pause` - Allows to pause the playbook.
    - Example 1 - pause for some time.
    ```
    ---
    -
    hosts: ubuntu3,centos3
    tasks:
        - name: Pause our playbook for 10 seconds
        pause:
            seconds: 10
    ...
    ```

    - Example 2 - pause using `prompt` ,until user enters.
    ```
    ---
    -
    hosts: ubuntu3,centos3
    tasks:
        - name: Prompt user to verify before continue
        pause:
            prompt: Please check that the webserver is running, press enter to continue
    ...
    ```
- `wait_for` - Allows the playbook to wait before next step.

    the playbook below, will use SSH to contant port 80, before it continues.
    ```
    ---
    -
    hosts: ubuntu3,centos3

    tasks:
        - name: Wait for the webserver to be running on port 80
        wait_for:
            port: 80
    ...

    ```
- `assemble` - module in Ansible is used to create a single file on a target host by assembling multiple source files from the Ansible control machine. It concatenates a collection of file fragments into one complete file on the remote system. This is particularly useful for managing configuration files or scripts that are composed of multiple parts, allowing you to maintain each part separately while deploying them as a unified file.
    
    - Source Directory (`src`):
        You specify a directory on the control machine containing all the file fragments to be assembled.
        All files within this directory are considered fragments and will be concatenated.
    
    - Destination File (`dest`):

        Specifies the path on the target host where the assembled file will be created.
        The assembled content is written to this file.

    - File Ordering:
        Fragments are assembled in lexicographical (alphabetical) order.
        You can control the order by naming files appropriately (e.g., prefixing with numbers like 01-, 02-).
        Optional Removal of Headers:

    - The `regexp` parameter can be used to remove certain lines (like headers  or comments) from each fragment during assembly.
    Useful for cleaning up fragments before concatenation.
    
    - File Attributes:
        You can set permissions (`mode`), ownership (`owner`, `group`), and other file attributes on the assembled file.
    
    The script below, will combine the file `conf.d` into `sshd.config`, it will "`assemble`" it.
    ```
    ---
    -

    hosts: ubuntu-c

    tasks
    tasks:
        - name: Assemble conf.d to sshd_config
        assemble:
            src: conf.d
            dest: sshd_config

    ...
    ```

- `add_host` - this allows us do dynamically add hosts to our playbook.
    - First Play:

        - Hosts: ubuntu-c
        - Purpose: Dynamically adds the host centos1 to two new groups: adhoc_group1 and adhoc_group2.
    - Second Play:

        - Hosts: adhoc_group1
        - Purpose: Executes the ping module on all hosts in adhoc_group1, which now includes centos1.
    
    ```
    ---
    -
    hosts: ubuntu-c

    tasks:
        - name: Add centos1 to adhoc_group
        add_host:
            name: centos1
            groups: adhoc_group1, adhoc_group2
    -
    hosts: adhoc_group1
    tasks:
        - name: Ping all in adhoc_group1
        ping:
    ...
    ```

- `group_by` - is used to dynamically create groups of hosts based on variables or facts gathered during playbook execution. This allows you to categorize hosts into groups based on specific criteria, which can be very useful for targeting tasks to hosts that share certain characteristics.
    - `Dynamic Grouping`: Instead of relying solely on static inventory files, group_by lets you group hosts at runtime based on their properties.

    - `Flexible Automation`: Enables more granular control over which hosts tasks are executed on, based on real-time data.

    - `Simplifies Playbooks`: Reduces the need for complex conditionals by grouping hosts intelligently.

    ```
    ---
    -
    hosts: all

    tasks:
        - name: Create group based on ansible_distribution
        group_by:
            key: "custom_{{ ansible_distribution | lower }}"

    -
    hosts: custom_centos

    tasks:
        - name: Ping all in custom_centos
        ping:
    ...

    ```

- `fetch` - used to copy files from remote hosts to the local machine (the machine where you run Ansible). Essentially, it allows you to retrieve files from your managed nodes and store them locally for analysis, backup, or archiving purposes. This is the opposite of the copy module, which copies files from the local machine to the remote hosts.
    ```
    ---
    -
    hosts: centos

    tasks:
        - name: Fetch /etc/redhat-release
        fetch:
            src: /etc/redhat-release
            dest: /tmp/redhat-release
    ...
    ```