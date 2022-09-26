#!/usr/bin/sh

INSTALL_CMD="paru -S --needed --noconfirm"

PKGS=(logiops)

if ! command -v paru > /dev/null; then
	sudo pacman -S git rustup --needed --noconfirm
	rustup install stable
	rustup default stable

	build_dir=`mktemp -d`
	git clone https://aur.archlinux.org/paru.git $build_dir
	cd $build_dir && makepkg -si --noconfirm
fi

$INSTALL_CMD ${PKGS[@]}
	
sudo systemctl enable logid --now
