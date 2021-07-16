#!/bin/bash
eth1ip=$(ifconfig |grep -A 1 eth1 | grep inet |awk '{print $2}')
echo "This task will take several minutes, please, take a coffee"
echo "[TASK1] System parameters."
sudo hostnamectl set-hostname checkmk.paradigmahome.lan
sudo sed -i 's/SELINUX=permissive/SELINUX=disabled/g' /etc/selinux/config
sudo yum upgrade -y &> /home/vagrant/upgrade.txt
sudo yum install epel-release -y &> /home/vagrant/epel.txt
echo "[TASK2] Install software."
sudo yum install nmap net-tools wget time traceroute dialog php libcap libgsf rpm-build postgresql-libs graphviz libdbi xinetd libcap poppler-utils graphviz-gd perl-Locale-Maketext-Simple perl-IO-Zlib php-xml php-xml php-pdo php-gd uuid freeradius-utils libpcap bind-utils php-mbstring net-snmp net-snmp-utils net-snmp-devel -y
cd /home/vagrant
#sudo wget https://checkmk.com/support/1.6.0p10/check-mk-raw-1.6.0p10-el7-38.x86_64.rpm --no-check-certificate
sudo wget https://download.checkmk.com/checkmk/1.6.0p22/check-mk-raw-1.6.0p22-el7-38.x86_64.rpm --no-check-certificate
#sudo rpm -i check-mk-raw-1.6.0p10-el7-38.x86_64.rpm &> /home/vagrant/proceso.txt
sudo yum install -y check-mk-raw-1.6.0p22-el7-38.x86_64.rpm
echo "[TASK3] Creating NEW SITES"
sudo omd create PRE  
sudo omd create PRO
sudo omd create DES
sudo omd create TST
htpasswd -mb /omd/sites/PRO/etc/htpasswd cmkadmin PRO
htpasswd -mb /omd/sites/PRE/etc/htpasswd cmkadmin PRE
htpasswd -mb /omd/sites/DES/etc/htpasswd cmkadmin DES
htpasswd -mb /omd/sites/TST/etc/htpasswd cmkadmin TST
omd restart
echo "[TASK4] Cleaning"
sudo yum clean all
cd /home/vagrant
sudo rm /home/vagrant/proceso.txt
yum clean all
echo "============================================================="
echo "========================= INFORMATION ======================="
echo "============================================================="
echo "Versión CheckMK:                                    1.6.0p22"
echo "Usuario de acceso web:                               cmkadmin"
echo "Access PRO: http://$eth1ip/PRO . Password: PRO"
echo "Access PRE: http://$eth1ip/PRE . Password: PRE"
echo "Access DES: http://$eth1ip/DES . Password: DES"
echo "Access TST: http://$eth1ip/TST . Password: TST"
echo "Info gathered in:               /home/vagrant/"
echo "============================================================="
