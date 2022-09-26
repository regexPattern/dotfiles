#!/usr/bin/sh

INSTALL_CMD="paru -S --needed --noconfirm"

PKGS=(
	brightnessctl # brightness control
	grim # simple CLI screenshots utils
	hyprland # wl-roots based compositor
	hyprpaper # wallpapers app for Hyprland
	mako # notification daemon
	qt5-wayland # adapt qt5 apps for wayland
	qt5ct # qt5 configuration utilities
	rofi-lbonn-wayland-git # rofi port for wayland
	slurp # wayland output selection tool
	waybar-hyprland-git # status bar for Hyprland
	wl-clipboard # clipboard utility
	wmctrl # window manager CLI controls
	wofi # rofi alternative for wayland
	xdg-desktop-portal-wlr # desktop portal for wl-roots
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
