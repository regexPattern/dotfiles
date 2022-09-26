#!/usr/bin/sh

INSTALL_CMD="sudo pacman -S --needed --noconfirm"

PKGS=(docker docker-compose)

$INSTALL_CMD ${PKGS[@]}

sudo groupadd docker
sudo usermod -aG docker $USER
sudo systemctl enable --now docker.service containerd.service
