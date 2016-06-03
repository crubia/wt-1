sudo -S yum update -y

sudo -S yum install net-tools -y

curl -fsSL https://get.docker.com/ | sh

sudo groupadd docker

sudo usermod -aG docker uc

sudo sed -i 's|fd://|tcp://0.0.0.0:2375|g' /usr/lib/systemd/system/docker.service

sudo systemctl start docker

sudo systemctl enable docker