#/bin/bash
apt-get -y install default-jre default-jdk software-properties-common mc htop sysstat dnsutils
wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add -
apt-get -y install apt-transport-https
echo "deb https://artifacts.elastic.co/packages/6.x/apt stable main" | sudo tee -a /etc/apt/sources.list.d/elastic-6.x.list
apt-get update && sudo apt-get -y install kibana haproxy nginx
#yes | /usr/share/kibana/bin/kibana-plugin install x-pack
systemctl enable kibana
