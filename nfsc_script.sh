#!/bin/bash
sudo yum install nfs-utils -y
sudo systemctl enable rpcbind
sudo systemctl start rpcbind
sudo mkdir /mnt/share
echo -e "192.168.50.10:/srv/nfs /mnt/share nfs defaults,vers=3 0 0" | sudo tee -a /etc/fstab
sudo mount -a