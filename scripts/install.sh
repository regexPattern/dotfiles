#!/usr/bin/env -S bash

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
	acpi
	bat
	bluez
	bluez-utils
	brave-bin
	cmake
	cmake
	discord
	docker
	docker-compose
	dragon-drop
	exa
	fd
	firefox
	fish
	fzf
	gimp
	github-cli
	glow
	go
	htop-vim
	hyperfine
	imagemagick
	kitty
	lf
	libconfig
	libinput-gestures
	logiops
	lxappearance
	man-db
	man-pages
	nodejs
	noto-fonts
	noto-fonts-emoji
	npm
	nsxiv
	obs-studio
	openssh
	pamixer
	pcmanfm-gtk3
	pfetch
	playerctl
	polkit
	python-pip
	qemu-desktop
	ripgrep
	solaar
	spotify
	spotify-tui
	spotifyd
	stow
	ttf-jetbrains-mono
	ttf-nerd-fonts-symbols-1000-em
	unzip
	virt-manager
	vlc
	wmctrl
	xdg-user-dirs
	xdotool
	zip
	zoxide
)

$INSTALL_CMD ${packages[@]}

bat() {
	bat cache --build
}

docker() {
	sudo groupadd docker
	sudo usermod -aG docker $USER
	sudo systemctl enable --now docker.service containerd.service
}

libinput-gestures() {
	sudo gpasswd -a $USER input
	libinput-gestures-setup stop desktop autostart start
}

logiops() {
	sudo systemctl enable logid --now
}

spotify-tui() {
}

virtmanager() {
	sudo groupadd libvirt
	sudo usermod -aG libvirt $USER
	sudo systemctl enable libvirtd --now
}

"$@"
