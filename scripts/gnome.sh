#!/usr/bin/sh

flatpak remote-add --if-not-exists flathub \
	https://flathub.org/repo/flathub.flatpakrepo

flatpak install -y flathub com.mattjakeman.ExtensionManager

# Shortcuts {{{

TERMINAL=kitty
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ binding "'<Super>Return'"
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ command "'$TERMINAL'"
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ name "'Terminal'"

gsettings set org.gnome.desktop.wm.keybindings close "['<Shift><Super>c']"
gsettings set org.gnome.desktop.wm.keybindings switch-windows "['<Alt>Tab', '<Super>Tab']"

# }}}

# Themes {{{

sudo dnf -y install \
	git             \
	gnome-tweaks    \
	meson           \
	ninja-build     \
	sassc

REPO_URL="https://github.com/lassekongo83/adw-gtk3.git"
BUILD_DIR=`mktemp -d`

git clone $REPO_URL $BUILD_DIR
cd $BUILD_DIR

meson build
cd build
sudo ninja install

gsettings set org.gnome.desktop.interface gtk-theme adw-gtk3
gsettings set org.gnome.desktop.peripherals.touchpad tap-to-click true
gsettings set org.gnome.mutter center-new-windows true
gsettings set org.gnome.settings-daemon.plugins.power false
gsettings set org.gnome.desktop.interface color-scheme prefer-dark

# }}}
