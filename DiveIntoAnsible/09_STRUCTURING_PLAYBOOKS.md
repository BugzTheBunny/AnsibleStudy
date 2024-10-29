# Structuring Playbooks


- `include` / `import` :  You can include / import other playbook's tasks, inside a playbook, using this:


    - `play1_task2.yaml`:
    ```
    ---
    - name: Play 1 - Task 2
    debug: 
        msg: Play 1 - Task 2
    ...
    ```

    - `include_tasks_playbook.yaml`
    ```
    ---
    -
    hosts: all

    tasks:

        - name: Play 1 - Task 1
        debug: 
            msg: Play 1 - Task 1

        - include_tasks: play1_task2.yaml
    ...
    ```


    - execution: `ansible-playbook include_tasks_playbook.yaml` - This will execute the playbook, in which we also include the `play1_task2.yaml` tasks.

    here we use `include_tasks` - the include tasks are pre-processed, meaning it first pre-processes the statemnets, and then executes the playbook.

    we can also use `import_tasks`, which will execute the commands, when encountering them, meaning it will not pre-proccess them.