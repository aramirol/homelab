#!/bin/bash
eth1ip=$(ifconfig |grep -A 1 eth1 | grep inet |awk '{print $2}')
echo "[TASK1] Config System"
sudo hostnamectl set-hostname graylog.jddr.lan
sudo sed -i 's/SELINUX=permissive/SELINUX=disabled/g' /etc/selinux/config
sudo yum upgrade -y &> /home/vagrant/upgrade.txt
sudo yum install epel-release -y &> /home/vagrant/epel.txt
echo "[TASK2] Installing java, elastic, mongo and their repos"
sudo yum -y install wget pwgen java-1.8.0-openjdk-headless &> /home/vagrant/others.txt
sudo rpm --import https://artifacts.elastic.co/GPG-KEY-elasticsearch
# REPO MongoDB
sudo cat << EOF > /etc/yum.repos.d/mongodb-org.repo
[mongodb-org-4.0]
name=MongoDB Repository
baseurl=https://repo.mongodb.org/yum/redhat/7/mongodb-org/4.0/x86_64/
gpgcheck=1
enabled=1
gpgkey=https://www.mongodb.org/static/pgp/server-4.0.asc
EOF
# REPO Elastic
sudo cat << EOF > /etc/yum.repos.d/elasticsearch.repo
[elasticsearch-6.x]
name=Elasticsearch repository for 6.x packages
baseurl=https://artifacts.elastic.co/packages/6.x/yum
gpgcheck=1
gpgkey=https://artifacts.elastic.co/GPG-KEY-elasticsearch
enabled=1
autorefresh=1
type=rpm-md
EOF
sudo yum install mongodb-org -y &> /home/vagrant/installMongo.txt
sudo systemctl daemon-reload
sudo systemctl enable mongod.service
sudo systemctl start mongod.service
sudo systemctl --type=service --state=active | grep mongod
sudo yum install elasticsearch -y &> /home/vagrant/installElasticSearch.txt
sudo sed -i 's/#cluster.name: my-application/cluster.name: graylog/g' /etc/elasticsearch/elasticsearch.yml
sudo systemctl daemon-reload
sudo systemctl enable elasticsearch
sudo systemctl restart elasticsearch
echo "======================== INSTALLING GRAYLOG 3.2 =================================="
sudo rpm -Uvh https://packages.graylog2.org/repo/packages/graylog-3.2-repository_latest.rpm
sudo yum install graylog-server -y &> /home/vagrant/graylog_install.txt
sudo sed -i "s/password_secret =/password_secret = 526HSw29TC8JrBlsJ3DmxhNlKloKwrf0RHD0uquN6dBEryIfSszTv7WDYBRka3xBaUDgRVPyoN8S392KhSufhDcRn1edIKTp/g" /etc/graylog/server/server.conf
sudo sed -i "s/root_password_sha2 =/root_password_sha2 = 165715b41bc7ee5be9aaca5da3b3cafce70678c42cb6cd2d637a6d0766eec8e9/g" /etc/graylog/server/server.conf 
sudo sed -i "s/#root_timezone = UTC/root_timezone = Europe\/\Madrid/g" /etc/graylog/server/server.conf
sudo sed -i "s/#http_bind_address = 127.0.0.1:9000/http_bind_address = $(ifconfig |grep -A 1 eth1 | grep inet |awk '{print $2}'):9000/g" /etc/graylog/server/server.conf
sudo systemctl daemon-reload
sudo systemctl enable graylog-server.service
sudo systemctl start graylog-server.service
sudo curl http://localhost:9200/_cluster/health?pretty > elasticsearchHealth.txt
sudo yum install graylog-enterprise-plugins graylog-integrations-plugins graylog-enterprise-integrations-plugins -y &> /home/vagrant/installEnterprisePlugins.txt
sudo systemctl restart graylog-server
sudo yum clean all
echo " Puedes acceder a través de http://$eth1ip:9000       "
echo " USUARIO: admin / CONTRASEÑA: Graylog                 "
sudo sed -i 's/{//g' elasticsearchHealth.txt && sed -i 's/}//' elasticsearchHealth.txt  && sed -i 's/"//g' /home/vagrant/elasticsearchHealth.txt
sudo cat /home/vagrant/elasticsearchHealth.txt
echo " Puedes encontrar más información de la instalación en /home/vagrant/                "
