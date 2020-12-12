#! /bin/bash
#git Install
sudo apt-get update
sudo apt-get -y install git
#Docker Install
sudo apt-get -y install apt-transport-https ca-certificates curl gnupg-agent software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo apt-key fingerprint 0EBFCD88
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt-get -y install docker-ce docker-ce-cli containerd.io
#Docker Compose Install
sudo curl -L "https://github.com/docker/compose/releases/download/1.27.4/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
sudo systemctl start docker
sudo systemctl enable docker
sudo usermod -a -G docker ubuntu
#Fabric Test Network Install
cd /tmp
curl -sSL https://bit.ly/2ysbOFE | bash -s
cd /tmp/fabric-samples/test-network
./network.sh up
#Create PostInstall Report
git --version > /tmp/postinstall.log
docker --version >> /tmp/postinstall.log
docker-compose --version >> /tmp/postinstall.log
docker ps >> /tmp/postinstall.log
