#!/bin/bash
sudo apt install pipx
pipx ensurepath

pipx install gns3-server==2.2.54
gns3server --version

sudo add-apt-repository ppa:gns3/ppa
sudo apt update && sudo apt install qemu-system-x86 qemu-utils libvirt-daemon-system libvirt-clients bridge-utils virt-manager ubridge

sudo usermod -aG kvm,libvirt,ubridge $(whoami)
sudo chown root:ubridge /usr/bin/ubridge
sudo chmod 4750 /usr/bin/ubridge

nano .config/GNS3/2.2/gns3_server.conf

sudo nano /etc/systemd/system/gns3.service
sudo systemctl daemon-reload
sudo systemctl enable gns3
sudo systemctl start gns3
sudo systemctl status gns3

sudo dpkg-reconfigure -plow unattended-upgrades
sudo nano /etc/apt/apt.conf.d/20auto-upgrades

curl -fsSL https://tailscale.com/install.sh | sh
sudo tailscale up