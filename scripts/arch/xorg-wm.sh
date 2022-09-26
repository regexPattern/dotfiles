#!/usr/bin/sh

INSTALL_CMD="paru -S --needed --noconfirm"

PKGS=(
	awesome
	maim
	xclip-git
	xcolor
	xdotool
	xinit
)

if ! command -v paru > /dev/null; then
	sudo pacman -S git rustup --needed --noconfirm
	rustup install stable
	rustup default stable

	build_dir=`mktemp -d`
	git clone https://aur.archlinux.org/paru.git $build_dir
	cd $build_dir && makepkg -si --noconfirm
fi

$INSTALL_CMD ${PKGS[@]}
