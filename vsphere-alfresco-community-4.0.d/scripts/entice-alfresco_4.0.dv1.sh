# Install Gnome so we can run firefox for selenium tests
#####sudo -S yum -y groupinstall "Desktop" "Desktop Platform" "X Window System" "Fonts"
sudo -S sed -i 's/id:3:initdefault:/id:5:initdefault:/' /etc/inittab


# Install Mysql
sudo -S yum install -y http://dev.mysql.com/get/mysql-community-release-el7-5.noarch.rpm
sudo -S yum install -y mysql-community-server 

sudo -S echo '# For advice on how to change settings please see
# http://dev.mysql.com/doc/refman/5.6/en/server-configuration-defaults.html

[mysqld]
#
# Remove leading # and set to the amount of RAM for the most important data
# cache in MySQL. Start at 70% of total RAM for dedicated server, else 10%.
# innodb_buffer_pool_size = 128M
#
# Remove leading # to turn on a very important data integrity option: logging
# changes to the binary log between backups.
# log_bin
#
# Remove leading # to set options mainly useful for reporting servers.
# The server defaults are faster for transactions and fast SELECTs.
# Adjust sizes as needed, experiment to find the optimal values.
# join_buffer_size = 128M
# sort_buffer_size = 2M
# read_rnd_buffer_size = 2M
datadir=/var/lib/mysql
socket=/var/lib/mysql/mysql.sock
bind-address=0.0.0.0


# Disabling symbolic-links is recommended to prevent assorted security risks
symbolic-links=0

# Recommended in standard MySQL setup
sql_mode=NO_ENGINE_SUBSTITUTION,STRICT_TRANS_TABLES

[mysqld_safe]
log-error=/var/log/mysqld.log
pid-file=/var/run/mysqld/mysqld.pid' > /etc/my.cnf





sudo -S systemctl start mysqld

sudo -S cd /tmp
sudo -S wget http://192.168.122.1:8000/create_alfresco_db.sql -O /tmp/create_alfresco_db.sql
sudo -S wget http://192.168.122.1:8000/grant_alfresco_user.sql -O /tmp/grant_alfresco_user.sql

sudo -S mysql -u root < /tmp/create_alfresco_db.sql
sudo -S mysql -u root < /tmp/grant_alfresco_user.sql



#Download and Install Alfresco 4.0.D 
sudo -S cd /tmp
#sudo -S wget http://dl.alfresco.com/release/community/build-4003/alfresco-community-4.0.d-installer-linux-x64.bin -O /tmp/alfresco-community-4.0.d-installer-linux-x64.bin
sudo -S wget http://192.168.122.1:8000/alfresco-community-4.0.d-installer-linux-x64.bin -O /tmp/alfresco-community-4.0.d-installer-linux-x64.bin
sudo -S echo 'mode=unattended
enable-components=javaalfresco,alfrescosharepoint,alfrescowcmqs
disable-components=postgres

# JDBC Settings
jdbc_url=jdbc:mysql://localhost/alfresco_db?useUnicode=yes&characterEncoding=UTF-8
jdbc_driver=org.gjt.mm.mysql.Driver
jdbc_database=alfresco_db
jdbc_username=alfresco_user
jdbc_password=alfrescopwd

alfresco_ftp_port=2121

prefix=/opt/alfresco-community-4.0.d

alfresco_admin_password=adminpwd
baseunixservice_install_as_service=0
alfrescocustomstack_services_startup=demand' > /tmp/install_opts

sudo -S cd /tmp

sudo -S chmod +x /tmp/alfresco-community-4.0.d-installer-linux-x64.bin 
sudo -S /tmp/alfresco-community-4.0.d-installer-linux-x64.bin --optionfile /tmp/install_opts 

sudo -S cd /tmp
sudo -S wget http://dev.mysql.com/get/Downloads/Connector-J/mysql-connector-java-5.1.38.tar.gz -O /home/alfresco/mysql-connector-java-5.1.38.tar.gz
sudo -S tar zxvf /home/alfresco/mysql-connector-java-5.1.38.tar.gz mysql-connector-java-5.1.38/mysql-connector-java-5.1.38-bin.jar
sudo -S mv /home/alfresco/mysql-connector-java-5.1.38/mysql-connector-java-5.1.38-bin.jar /opt/alfresco-community-4.0.d/tomcat/lib/
