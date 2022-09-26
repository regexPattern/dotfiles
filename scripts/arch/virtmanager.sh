#!/usr/bin/sh

INSTALL_CMD="sudo pacman -S --needed --noconfirm"

PKGS=(qemu-desktop virt-manager)

$INSTALL_CMD ${PKGS[@]}
	
sudo groupadd libvirt
sudo usermod -aG libvirt $USER
sudo systemctl enable libvirtd --now
