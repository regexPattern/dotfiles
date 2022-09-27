#!/usr/bin/sh

# This might help: https://askubuntu.com/questions/971067/how-can-i-script-the-settings-made-by-gnome-tweak-tool
sudo dnf -y install gnome-tweaks

sudo dnf -y install \
	git meson ninja-build sassc

REPO_URL="https://github.com/lassekongo83/adw-gtk3.git"
BUILD_DIR=`mktemp -d`

git clone $REPO_URL $BUILD_DIR
cd $BUILD_DIR

meson build
cd build
sudo ninja install

gsettings set org.gnome.desktop.interface gtk-theme adw-gtk3

flatpak install flathub com.mattjakeman.ExtensionManager
