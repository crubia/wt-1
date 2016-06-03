#Install mysql repository
sudo -S yum install -y http://dev.mysql.com/get/mysql-community-release-el7-5.noarch.rpm
sudo -S yum install -y mysql-community-server mysql-community-devel.x86_64

#Modificando el archivo my.cnf
sudo -S echo '# For advice on how to change settings please see
# http://dev.mysql.com/doc/refman/5.6/en/server-configuration-defaults.html

[mysqld]
datadir=/var/lib/mysql
socket=/var/lib/mysql/mysql.sock
bind-address=0.0.0.0


# Disabling symbolic-links is recommended to prevent assorted security risks
symbolic-links=0

# Recommended in standard MySQL setup
sql_mode=NO_ENGINE_SUBSTITUTION,STRICT_TRANS_TABLES

[mysqld_safe]
log-error=/var/log/mysqld.log
pid-file=/var/run/mysqld/mysqld.pid' > /tmp/my.cnf

sudo -S mv /tmp/my.cnf /etc/my.cnf

sudo -S systemctl start mysqld

cd /tmp
sudo -S wget http://192.168.122.1:9000/create_redmine_db.sql -O /tmp/create_redmine_db.sql
sudo -S wget http://192.168.122.1:9000/grant_redmine_user.sql -O /tmp/grant_redmine_user.sql

sudo -S mysql -u root < /tmp/create_redmine_db.sql
sudo -S mysql -u root < /tmp/grant_redmine_user.sql



#Download and Install Redmine 3.2.0 
#Install packages
sudo -S yum install -y git-svn.x86_64 curl.x86_64 zlib-devel.x86_64 openssl-devel.x86_64 readline-devel.x86_64 libyaml-devel.x86_64 sqlite-devel.x86_64 libxml2-devel.x86_64 libxslt-devel.x86_64 libcurl-devel.x86_64 python.x86_64 libffi-devel.x86_64 ImageMagick-devel.x86_64

sudo -S wget http://www.redmine.org/releases/redmine-3.2.0.tar.gz -O /opt/redmine-3.2.0.tar.gz
cd /opt
sudo -S tar zxvf /opt/redmine-3.2.0.tar.gz


sudo -S echo 'production:
  adapter: mysql2
  database: redmine_db
  host: localhost
  username: redmine_user 
  password: "redminepwd"
  encoding: utf8' > /tmp/database.yml

sudo -S mv /tmp/database.yml /opt/redmine-3.2.0/config/database.yml

cd
git clone git://github.com/sstephenson/rbenv.git .rbenv
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bash_profile 
export PATH="$HOME/.rbenv/bin:$PATH" 
echo 'eval "$(rbenv init -)"' >> ~/.bash_profile 
eval "$(rbenv init -)"

git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build 
echo 'export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"' >> ~/.bash_profile
export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"

rbenv install 2.2.3
rbenv global 2.2.3

echo "gem: --no-ri --no-rdoc" > /home/redmine/.gemrc
gem install mysql2 -v '0.3.20'
gem install bundler --no-ri --no-rdoc

cd /opt/redmine-3.2.0
sudo -S chown -R redmine /opt/redmine-3.2.0

bundle install --without development test
bundle exec rake generate_secret_token

RAILS_ENV=production bundle exec rake db:migrate

