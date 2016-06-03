#Install mysql repository
yum install -y http://dev.mysql.com/get/mysql-community-release-el7-5.noarch.rpm
yum install -y mysql-community-server

#Modificando el archivo my.cnf
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
sudo -S wget http://192.168.122.1:9000/create_redmine_db.sql -O /tmp/create_redmine_db.sql
sudo -S wget http://192.168.122.1:9000/grant_redmine_user.sql -O /tmp/grant_redmine_user.sql

sudo -S mysql -u root < /tmp/create_redmine_db.sql
sudo -S mysql -u root < /tmp/grant_redmine_user.sql



#Download and Install Redmine 3.2.0 
#Install packages
sudo -S yum install -y git-svn.x86_64 curl.x86_64 zlib-devel.x86_64 openssl-devel.x86_64 readline-devel.x86_64 libyaml-devel.x86_64 sqlite-devel.x86_64 libxml2-devel.x86_64 libxslt-devel.x86_64 libcurl-devel.x86_64 python.x86_64 libffi-devel.x86_64 ImageMagick-devel.x86_64

sudo -S wget http://www.redmine.org/releases/redmine-3.2.0.tar.gz -O /opt/redmine-3.2.0.tar.gz
sudo -S cd /opt
sudo -S tar zxvf /opt/redmine-3.2.0.tar.gz


sudo -S echo 'production:
  adapter: mysql2
  database: redmine_db
  host: localhost
  username: redmine_user 
  password: "redminepwd"
  encoding: utf8' > /opt/redmine-3.2.0/config/database.yml


sudo -S git clone git://github.com/sstephenson/rbenv.git /home/redmine/.rbenv
sudo -S echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> /home/redmine/.bashrc
sudo -S echo 'eval "$(rbenv init -)"' >> /home/redmine/.bashrc
sudo -S git clone https://github.com/rbenv/ruby-build.git /home/redmine/.rbenv/plugins/ruby-build

sudo -S rbenv install 2.2.3
sudo -S rbenv global 2.2.3

sudo -S echo "gem: --no-ri --no-rdoc" > /home/redmine/.gemrc
sudo -S gem install mysql2 -v '0.3.20'
sudo -S bundle install --without development test
sudo -S bundle exec rake generate_secret_token

sudo -S cd /opt/redmine-3.2.0
sudo -S RAILS_ENV=production bundle exec rake db:migrate

