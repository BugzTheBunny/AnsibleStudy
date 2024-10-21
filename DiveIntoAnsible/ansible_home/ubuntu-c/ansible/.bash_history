ssh ubuntu1
cd .ssh
cat known_hosts 
ssh-keygen -H -F ubuntu1
ping ubuntu1
ssh-keygen 
cat .ssh/id_rsa.pub
cat id_rsa.pub 
ssh-copy-id ansible@ubuntu1
ssh ansible@ubuntu1
ssh-copy-id ansible@ubuntu2
sudo apt update
sudo apt install sshpass
sudo apt update
sudo apt install sshpass
clear
echo password > password.txt
cat password.txt 
clear
ls
for user in ansible root; do   for os in ubuntu centos;   do     for instance in 1 2 3;     do        sshpass -f password.txt ssh-copy-id -o StrictHostChecking=no ${user}@${os}${instance};     done;   done; done
for user in ansible root; do   for os in ubuntu centos;   do     for instance in 1 2 3;     do        sshpass -f password.txt ssh-copy-id -o StrictHostKeyChecking=no ${user}@${os}${instance};     done;   done; done
cat password.txt 
ls
rm password.txt 
ssh ansible@centos3
ansible -i,ubuntu1,ubuntu2,ubuntu3,centos1,centos2,centos3 all -m ping
rm known_hosts 
ls
cd ..
ansible --version
u -
su -
ansible--version
ansible --version
cd ~
ls
pwd
ls -a
touch .ansible.cfg
ls
ls -a
ansible --version
mkdir testdir
cd testdir/
ansible --version
touch ansible.cfg
ansible --version
cd ..
rm -rf testdir/
touch this_is_my_example_ansible.cfg
export ANSIBLE_CONFIG=/home/ansible/this_is_my_example_ansible.cfg
ansible --version
unsuet ANSIBLE_CONFIG
unset ANSIBLE_CONFIG
sudo rm this_is_my_example_ansible.cfg 
sudo rm /etc/ansible/ansible.cfg 
sudo rmdir /etc/ansible/
rm ~/.ansible.cfg 
ls
git
git clone https://github.com/spurin/diveintoansible.git
ls
cd 
cd diveintoansible/
ls
cd Ansible\
cd Ansible Architecture and Design
cd "Ansible Architecture and Design"
ls
cd Inventories/
ls
CD 01/
cd 01
ls
ping centos1
cat hosts 
cd ./ansible.cfg 
cat ./ansible.cfg 
ansible all -m ping
ANSIBLE_HOST_KEY_CHECKING=False ansible all -m ping
cd ..
cd 02/
ls
cat ansible.cfg 
rm -rf /home/ansible/.ssh/known_hosts 
ls
ANSIBLE_HOST_KEY_CHECKING=False ansible all -m ping
cat /home/ansible/.ssh/known_hosts 
rm -rf /home/ansible/.ssh/known_hosts 
cat ansible.cfg 
ansible all -m ping
vim hosts 
ansible all -m ping
ansible x -m ping
vim hosts 
cat ansible.cfg 
cd ..
cd 03
cat hosts 
ansible-inventory --list | jq "keys"
ansible-inventory --list
ansible all ping
ansible all -m ping
ansible all -m ping -o
ansible centos --list-hosts
ansible ~.*3 --list-hosts
cd ..
cd 04
ls
cat hosts 
ansible all -m ping -o
id
ansible all -m command -a 'id' -o
cd ..
cd 05
ansible all -m command -a 'id' -o
ssh root@centos
ssh root@centos -p 2222
ssh root@centos1
cd ..
cd 06/
cd ..
cd 07
ls
cd diveintoansible/
ls
cd 'Ansible Architecture and Design'
ls
cd Inventories/
cd 09/
ls
cat hosts 
ansible all --list-hosts
cd ..
cd 10
ansible all --list-hosts
cd ..
cd 12
cd ..
cd Modules/
ls
ansible centos1 -m setup
ansible all -m file -a 'path=/tmp/test state=touch'
ls
cd diveintoansible/
ls
cd 'Ansible Architecture and Design'
cd Modules/
ls
ansible all -a 'touch /tmp/test_command_module creates =/tmp/test_command_module'
vim hosts 
ansible all -a 'hostname' -o
ansible all -a 'touch /tmp/test_command_module creates =/tmp/test_command_module'
ansible all -a 'touch /tmp/test_command_module creates=/tmp/test_command_module'
ansible all -a 'rm /tmp/test_command_module removes=/tmp/test_command_module'
cd ..
ls
cd 'Ansible Playbooks, Introduction'
ls
cd 'Ansible Playbooks, Breakdown of Sections'
cd 02
ls
cat centos_motd 
ansible-playbook motd_playbook.yaml 
ls
vim hosts 
ansible-playbook motd_playbook.yaml 
time ansible-playbook motd_playbook.yaml 
cd ..
cd 03/
time ansible-playbook motd_playbook.yaml 
vim hosts 
time ansible-playbook motd_playbook.yaml 
cd diveintoansible/
ls
cd 'Ansible Playbooks, Introduction'/
LS
ls
cd Ansible\ Playbooks\,\ Variables/
ls
cd 01/
ls
cat variables_playbook.yaml 
ls
ls -a
cd ..
ls
./show_examples.sh 
cd ..
cd Ansible\ Playbooks\,\ Facts/
cd 01/
ssh ansible@centos1
ansible centos1 -m setup -a 'gather_subset=network' | more
ssh ansible@centos1
ansible centos1 -m setup -a 'gather_subset=network' | more
ssh ansible@centos1
cd ..
ls
cd 04/
ls
cd ..
cd 03/
ls
cd templates/
ls
sudo mkdir -p /etc/ansible/facts.d
sudo cp * /etc/ansible/facts.d/
cat /etc/ansible/facts.d/
ls /etc/ansible/facts.d/
cd ..
ansible ubuntu-c setup | more
ansible ubuntu-c -m setup | more
ansible ubuntu-c -m setup -a 'filter=ansible_local'
