#base
sudo -S sed -i "s/^.*requiretty/#Defaults requiretty/" /etc/sudoers
sudo -S yum -y install gcc

#wget
sudo -S yum -y install wget

#bzip
sudo -S yum -y install bzip2 



#set network interface
sudo -S echo "DEVICE=eth0
BOOTPROTO=dhcp
ONBOOT=yes
USERCTL=yes" > /etc/sysconfig/network-scripts/ifcfg-eth0

#Disable iptables
sudo -S systemctl mask firewalld
sudo -S systemctl stop firewalld


#Set timezone
sudo -S ln -sf /usr/share/zoneinfo/Europe/Madrid /etc/localtime 
