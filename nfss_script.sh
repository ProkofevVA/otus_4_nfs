#!/bin/bash
sudo yum install nfs-utils nfs-utils-lib firewalld -y
sudo mkdir -p /srv/nfs
sudo chmod -R 755 /srv/nfs
sudo mkdir -p /srv/nfs/upload
sudo chmod -R 777 /srv/nfs/upload
sudo systemctl enable rpcbind
sudo systemctl enable nfs-server
sudo systemctl enable firewalld

echo -e "/srv/nfs 192.168.50.10/24(rw,sync,no_root_squash,no_all_squash)" > /etc/exports
exportfs -a
sudo systemctl restart nfs-server

sudo systemctl start firewalld
sudo firewall-cmd --permanent --add-port=111/tcp
sudo firewall-cmd --permanent --add-port=2049/tcp
sudo firewall-cmd --permanent --zone=public --add-service=nfs
sudo firewall-cmd --permanent --zone=public --add-service=mountd
sudo firewall-cmd --permanent --zone=public --add-service=rpc-bind
sudo firewall-cmd --reload
sudo systemctl restart firewalld
sudo systemctl start rpcbind