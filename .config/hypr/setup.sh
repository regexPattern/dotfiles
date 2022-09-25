#!/usr/bin/sh

if ! command -v paru > /dev/null; then
	sudo pacman -S git rustup --needed --noconfirm
	rustup install stable
	rustup default stable

	build_dir=`mktemp -d`
	git clone https://aur.archlinux.org/paru.git $build_dir
	cd $build_dir && makepkg -si --noconfirm
fi

INSTALL_CMD="paru -S --needed --noconfirm" 

packages=(
	brightnessctl
	grim
	hyprland
	hyprpaper
	mako
	qt5-wayland
	qt5ct
	rofi-lbonn-wayland-git
	slurp
	waybar-hyprland-git
	wl-clipboard
	wofi
	xdg-desktop-portal-wlr
)

$INSTALL_CMD ${packages[@]}
