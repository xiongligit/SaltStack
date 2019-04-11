### 1.安装salt-master salt-minion

#### salt-master:
```shell
安装
yum -y install epel-release
yum -y install salt-master
```

```shell
修改配置文件 
vim /etc/salt/master
auto_accept: true
file_roots:
  base:
    - /srv/salt/
```

```shell
重启
systemctl restart salt-master
systemctl enable salt-master
```

#### salt-miion
```shell
安装
yum -y install epel-release
yum -y install salt-minion
```

```shell
修改配置文件
vim /etc/salt/minion 
master: 192.168.1.1     ---master的IP
id: test02
```

```shell
重启
systemctl restart salt-master
systemctl enable salt-master
```

### 2.批量部署
#### salt-master:
```shell
cd /srv/salt
git clone https://github.com/xiongligit/SaltStack.git
mv SaltStack /srv/salt/install
salt 'test02' state.sls sls/install/install_nginx/install_nginx
```
