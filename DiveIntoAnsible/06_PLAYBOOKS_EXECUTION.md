# Creation and Execution

- ### Installing EPEL on centos linux distros.
    In the example below, we will install epel-release using `yum`, only `when` the `ansible_distribution` is `CentOS` 
    ```
    ---
    -
    hosts: linux
    tasks:
        - name: Install EPEL
        yum:
            name: epel-release
            update_cache: yes
            state: latest
        when: ansible_distribution == 'CentOS'
    ...
    ```

- ### Installing EPEL on Centos and Ngnix on CentOS nad Ubuntu
    ```
    ---
    -
    hosts: linux
    tasks:
        - name: Install EPEL
        yum:
            name: epel-release
            update_cache: yes
            state: latest
        when: ansible_distribution == 'CentOS'

        - name: Install Nginx CentOS
        yum:
            name: nginx
            update_cache: yes
            state: latest
        when: ansible_distribution == 'CentOS'

        - name: Install Nginx Ubuntu
        apt:
            name: nginx
            update_cache: yes
            state: latest
        when: ansible_distribution == 'Ubuntu'
    ...

    ```
- ### Installing in a better / shorter way:
    This does the same as above, but here we are using the `package` module, which replaces all other package managers such as `yum`, `apt` and so on.
    we also use `latest`.

    `state: latest` ensures that the package manager will use the latest version of ngnix and epel-release.

    ```
    ---
    -
    hosts: linux
    tasks:
        - name: Install EPEL
        yum:
            name: epel-release
            update_cache: yes
            state: latest
        when: ansible_distribution == 'CentOS'

        - name: Install Nginx
        package:
            name: nginx
            state: latest
    ...

    ```
- ### Restarting a service
    This way, we can `restart` a `service`, for example ngnix after installing it.
    ```
        - name: Install Nginx
      package:
        name: nginx
        state: latest

    - name: Restart nginx
      service:
        name: nginx
        state: restarted
    ```

- ### Restarting and checking using HTTP request.
    ```
    ---
    -
    hosts: linux
    tasks:
        - name: Install EPEL
        yum:
            name: epel-release
            update_cache: yes
            state: latest
        when: ansible_distribution == 'CentOS'

        - name: Install Nginx
        package:
            name: nginx
            state: latest

        - name: Restart nginx
        service:
            name: nginx
            state: restarted
        notify: Check HTTP Service

    handlers:
        - name: Check HTTP Service
        uri:
            url: http://{{ ansible_default_ipv4.address }}
            status_code: 200 

    ...

    ```