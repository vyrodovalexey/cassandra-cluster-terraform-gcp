#/bin/bash
apt-get -y install default-jre default-jdk software-properties-common mc htop sysstat dnsutils
wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add -
echo "* hard nofile 1000000" >> /etc/security/limits.conf
echo "* soft nofile 1000000" >> /etc/security/limits.conf
apt-get -y install apt-transport-https
echo "deb https://artifacts.elastic.co/packages/6.x/apt stable main" | sudo tee -a /etc/apt/sources.list.d/elastic-6.x.list
apt-get update && sudo apt-get -y install elasticsearch
avail_mem=$(( `free -m | grep Mem | awk '{print $7}'`/2 ))
echo "MAX_OPEN_FILES=655350" >> /etc/default/elasticsearch
#echo "MAX_LOCKED_MEMORY=unlimited" >> /etc/default/elasticsearch
echo "ES_HEAP_SIZE="$avail_mem"m" >> /etc/default/elasticsearch
yes | /usr/share/elasticsearch/bin/elasticsearch-plugin install x-pack
yes | /usr/share/elasticsearch/bin/elasticsearch-plugin install analysis-icu
yes | /usr/share/elasticsearch/bin/elasticsearch-plugin install ingest-geoip
systemctl enable elasticsearch
