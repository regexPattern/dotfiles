#!/usr/bin/sh

REPO_URL="https://github.com/hyprwm/Hyprland"
BUILD_DIR=`mktemp -d`

sudo dnf -y install \
	cairo-devel     \
	cmake           \
	gcc-c++         \
	libX11-devel    \
	libxcb-devel    \
	meson           \
	ninja-build     \
	pango-devel     \
	pixman-devel    \
	wayland-protocols-devel

git clone --recursive $REPO_URL $BUILD_DIR
cd $BUILD_DIR

sudo make install

sudo dnf -y install \
	rofi \
	waybar
