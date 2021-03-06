#base
sudo -S sed -i "s/^.*requiretty/#Defaults requiretty/" /etc/sudoers

#set network interface
echo "DEVICE=eth0
BOOTPROTO=dhcp
ONBOOT=yes
USERCTL=yes" > /etc/sysconfig/network-scripts/ifcfg-eth0

#Disable iptables
sudo -S systemctl mask firewalld
sudo -S systemctl stop firewalld

#Disable IPV6
sudo -S echo "net.ipv6.conf.all.disable_ipv6 = 1" >> /etc/sysctl.conf


#Set timezone
sudo -S ln -sf /usr/share/zoneinfo/Europe/Madrid /etc/localtime 
