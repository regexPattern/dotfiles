#!/usr/bin/sh

INSTALL_CMD="sudo pacman -S --needed --noconfirm"

PKGS=(bat)

$INSTALL_CMD ${PKGS[@]}

bat cache --build
