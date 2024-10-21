# Playbook Facts

- `ansible centos1 -m setup -a 'gather_subset=network' | more`

- ### `!all` & `!min`:  
    The `!all` and `!min` syntax in Ansible is used in the context of fact gathering to control which facts are collected. These are special fact `gathering filter options` that allow you to optimize and fine-tune the fact collection process in your playbook runs.

    ```
    ---
    - name: Example of using !all and !min in fact gathering
    hosts: all
    gather_facts: yes
    gather_subset:
        - "!all"   # Do not gather all facts
        - "!min"   # Gather only the minimal facts

    tasks:
        - name: Print the hostname (one of the minimal facts)
        debug:
            msg: "Hostname is {{ ansible_facts['hostname'] }}"
    ```
- ### Other Fact Gathering Filters:
    You can also use other filters in addition to !all and !min to gather specific subsets of facts. Some examples:

    - `hardware`: Collect hardware-related facts.
    - `network`: Collect network-related facts.
    - `virtual`: Collect virtualization-related facts.

    ```
    gather_subset:
        - "!all"
        - "network"  # Only gather network-related facts
    ```

    `ansible ubuntu-c -m setup -a 'filter=ansible_local'` - Will allow you to get the facts that are related only to `ansible_local`

- ### Getting data from collected facts.
    The playbook below will show IP addresses.
    ```
    -
    hosts: all
    tasks:
        - name: Show IP Address
        debug:
            msg: "{{ ansible_default_ipv4.address }}"
    ...
    ```

- ### Custom Facts
    - You can create and gather custom facts for ansible, they will return in a JSON / ini format.
    - they are expected to be inside `/etc/ansible/facts.d` 

- ### More facts options
    You can refresh facts.
    Let's assume you copied 2 facts files into the targets, and you want to refresh the facts, you can do it by doing this:
    ```
    - name: Refresh Facts
    setup:
    ```
    - if you use `setup:` it will rerun the setup, and get the updated facts.
    - or you can provide a path, to reload facts:
    ```
    - name: Refresh Facts
    setup:
        fact_path: /home/ansible/facts.d
    ```