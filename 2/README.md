Задача.

Создать Ansible-роль для провизионинга связки Nginx+Apache+mod_php в дефолтной конфигурации на сервере Ubuntu 14.04.

Решение:

- Корневая система для контейнеров: 
cat /etc/lsb-release | grep DESCRIPTION
DISTRIB_DESCRIPTION="Ubuntu 16.04.3 LTS”

- Из за отсутствия дистрибутива Ubuntu 14.04 я использую lxc-контейнер: 
sudo apt-get install lxc

# lxc-create -t download -n lab

Distribution: ubuntu
Release: trusty
Architecture: amd64

Downloading the image index
Downloading the rootfs
Downloading the metadata
The image cache is now ready
Unpacking the rootfs

# lxc-start -n lab -d

# lxc-attach -n lab

root@lab:/etc# lsb_release -a
No LSB modules are available.
Distributor ID:	Ubuntu
Description:	Ubuntu 14.04.5 LTS
Release:	14.04
Codename:	trusty

Кол-во пакетов после первой установки:

root@lab:/etc# dpkg --list | wc -l
223

Добавляю openssh-server для удаленной работы с контейнером:

root@lab:/etc# apt-get install openssh-server

В /etc/ssh/sshd_config указываю значение параметра:  PermitRootLogin yes

Меняю пароль пользователя root

root@lab:~# passwd root
Enter new UNIX password: 
Retype new UNIX password: 
passwd: password updated successfully
Устанавливаю ansible:

apt-get install ansible

Узнаю адрес контейнера:  # lxc-info -n lab | grep IP
IP:             10.0.3.14

Добавляю полученный адрес:

echo '10.0.3.14' >> /etc/ansible/hosts

Поверяю доступность контейнера:  # ansible -m ping 10.0.3.14
10.0.3.14 | SUCCESS => {
    "changed": false, 
    "ping": "pong"
}

Создаю playbook и размещаю его по адресу:

https://github.com/amarshalenko/test/tree/master/2/websrv.yml

