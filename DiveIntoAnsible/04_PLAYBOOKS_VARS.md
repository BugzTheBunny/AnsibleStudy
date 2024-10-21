# Vars Options for a Playbook

### `vars_files` 
In Ansible, `vars_files` is an option used to include external YAML files that define variables for your playbook. These files can be used to manage variable data separately from your playbook, helping keep the playbook clean and modular. Instead of hardcoding variables directly in the playbook, you can load them from external files using vars_files.

```
- name: Example Playbook using vars_files
  hosts: all
  vars_files:
    - vars/common_vars.yml
    - vars/special_vars.yml

  tasks:
    - name: Print a variable from the common_vars.yml
      ansible.builtin.debug:
        msg: "{{ some_common_var }}"

    - name: Print a variable from the special_vars.yml
      ansible.builtin.debug:
        msg: "{{ special_var }}"
```

### `vars_prompt`

In Ansible, `vars_prompt` is a feature that allows you to prompt the user for input when running a playbook. This is useful when you need dynamic input or sensitive information (like passwords) that shouldn't be hardcoded or stored in a variables file.

```
---
- name: Playbook using vars_prompt
  hosts: all
  vars_prompt:
    - name: "username"
      prompt: "What is your username?"
      private: no

    - name: "password"
      prompt: "Enter your password"
      private: yes

  tasks:
    - name: Print the username
      ansible.builtin.debug:
        msg: "Username: {{ username }}"

    - name: Use the password in a secure way (not shown here)
      ansible.builtin.debug:
        msg: "Password is hidden"

```
- #### Key Parameters:
- `name`: The variable name to be assigned to the input.
- `prompt`: The message displayed to the user when prompting for input.
- `private`: If set to yes, the input will be hidden (useful for sensitive data like passwords). If no, the input will be displayed as the user types.
- `default`: (Optional) You can specify a default value, so the user doesn't have to input it manually unless they want to override it.
- `encrypt`: (Optional) Can be used to encrypt the input (e.g., md5_crypt, sha512_crypt).
- `confirm`: (Optional) If set to yes, the user will be prompted to confirm their input (useful for passwords or other sensitive data).

### Passing a file of variables via command:
The command below will pass a file of variables in the yaml format to the playbook, you can also pass a json.
- `ansible-playbook variables_playbook.yaml -e @extra_vars_file.yaml` 