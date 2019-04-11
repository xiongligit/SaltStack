1.安装salt-master salt-minion
-----
salt-master:
安装
```shell
yum -y install epel-release
yum -y install salt-master
```

修改配置文件 
```shell
vim /etc/salt/master
auto_accept: true
file_roots:
  base:
    - /srv/salt/
```

重启
```shell
systemctl restart salt-master
systemctl enable salt-master
```

salt-miion
安装
```shell
yum -y install epel-release
yum -y install salt-minion
```

修改配置文件
```shell
vim /etc/salt/minion 
master: 192.168.1.1     ---master的IP
id: test02
```

重启
```shell
systemctl restart salt-master
systemctl enable salt-master
```

2.批量部署
------
```shell
salt-master:
cd /srv/salt
git clone https://github.com/xiongligit/SaltStack.git
mv SaltStack /srv/salt/install
salt 'test02' state.sls sls/install/install_nginx/install_nginx
```
