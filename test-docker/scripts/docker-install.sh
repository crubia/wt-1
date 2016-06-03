sudo -S yum update -y

sudo -S yum install net-tools wget -y

curl -fsSL https://get.docker.com/ | sh

sudo groupadd docker

sudo usermod -aG docker test

sudo systemctl start docker

sudo systemctl enable docker