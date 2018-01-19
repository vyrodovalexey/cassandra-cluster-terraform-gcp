#/bin/bash
apt-get -y install apt-transport-https
curl -sL https://repos.influxdata.com/influxdb.key | apt-key add -
echo "deb https://repos.influxdata.com/debian stretch stable" | sudo tee /etc/apt/sources.list.d/influxdb.list
apt-get update
apt-get -y install mc  htop sysstat dnsutils curl wget net-tools apt-file git golang python python-pip python-dev influxdb kapacitor haproxy
echo "* hard nofile 1000000" >> /etc/security/limits.conf
echo "* soft nofile 1000000" >> /etc/security/limits.conf
export GOPATH=/usr
go get github.com/influxdata/inch/cmd/inch
go get -u github.com/influxdata/influxdb-relay
mkdir /var/lib/influxdb-relay /var/log/influxdb-relay /run/influxdb-relay /etc/influxdb-relay
cp -r /usr/src/github.com/influxdata/influxdb-relay/scripts /etc/influxdb-relay
sed -i 's/\/usr\/lib\/influxdb-relay\/scripts/\/etc\/influxdb-relay\/scripts/g' /etc/influxdb-relay/scripts/post-install.sh
chmod +x /etc/influxdb-relay/scripts/post-install.sh
/etc/influxdb-relay/scripts/post-install.sh
systemctl enable influxdb-relay
systemctl enable influxdb
systemctl enable haproxy