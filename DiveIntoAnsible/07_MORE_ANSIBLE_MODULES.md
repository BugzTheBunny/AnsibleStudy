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