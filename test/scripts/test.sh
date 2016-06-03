sudo -S yum --skip-broken -y groups install "GNOME Desktop" #Excesivamente grande, instala tonterias como libreoffice, tengo que mirar algo más ligero

sudo -S systemctl set-default graphical.target

cd /home/test/

curl "https://bootstrap.pypa.io/get-pip.py" -o "/home/test/get-pip.py"
sudo -S python /home/test/get-pip.py

sudo -S yum install -y firefox redis wget

sudo -S systemctl start redis.service
sudo -S systemctl enable redis.service

sudo -S systemctl disable initial-setup-graphical.service

mkdir /home/test/api/
cd /home/test/api/

wget http://10.200.3.106:8890/server/alfresco.py -O /home/test/api/alfresco.py
wget http://10.200.3.106:8890/server/api_test_alfresco.py -O /home/test/api/api_test_alfresco.py

wget http://10.200.3.106:8890/server/redmine.py -O /home/test/api/redmine.py
wget http://10.200.3.106:8890/server/api_test_redmine.py -O /home/test/api/api_test_redmine.py

wget http://10.200.3.106:8890/server/dataStore.py -O /home/test/api/dataStore.py
wget http://10.200.3.106:8890/server/tokens.py -O /home/test/api/tokens.py
wget http://10.200.3.106:8890/server/settings.py -O /home/test/api/settings.py
wget http://10.200.3.106:8890/server/requirements.txt -O /home/test/api/requirements.txt

wget http://10.200.3.106:8890/server/custom.conf -O /home/test/api/custom.conf

sudo -S pip install -r /home/test/api/requirements.txt --force-reinstall --upgrade -I

sudo -S rm /etc/gdm/custom.conf
sudo -S cp /home/test/api/custom.conf /etc/gdm/custom.conf

mkdir /home/test/.config
cd /home/test/.config/
echo 'yes' > /home/test/.config/gnome-initial-setup-done

mkdir /home/test/.config/autostart/
cd /home/test/.config/autostart/
wget http://10.200.3.106:8890/server/alfresco.desktop -O /home/test/.config/autostart/alfresco.desktop
wget http://10.200.3.106:8890/server/redmine.desktop -O /home/test/.config/autostart/redmine.desktop

sudo -S chown -R test:test /home/test/api
sudo -S chown -R test:test /home/test/.config