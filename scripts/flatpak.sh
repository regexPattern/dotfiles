#!/usr/bin/sh

INSTALL_CMD="sudo pacman -S --needed --noconfirm"

PKGS=(flatpak)

$INSTALL_CMD ${PKGS[@]}

flatpak install -y flathub com.brave.Browser
flatpak install -y flathub com.discordapp.Discord
flatpak install -y flathub com.obsproject.Studio
flatpak install -y flathub com.spotify.Client
flatpak install -y flathub org.gimp.GIMP
flatpak install -y flathub org.mozilla.firefox
