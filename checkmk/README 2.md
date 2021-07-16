# CheckMK_vagrant

Vagrantfile + shellscript to deploy CheckMK monitoring appliance as VM in Oracle Virtualbox. 

* **How_To_Run**: Just play it -- vagrant up

## Info

Script takes the second IP provided in the VM (first for Vagrant comunication and the second for the service)

* **Image_ID: bento/centos7**
* **var_mem: 2048**
* **var_cpu: 2**
* **ver_checkmk: 1.6.0p10**
* **provider: Virtualbox** 

At the end of deployment u'll see the URL access, user & pass.

Have fun.