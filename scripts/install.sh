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
	git-delta
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
	maim
	man-db
	man-pages
	neofetch
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
	python-pulsectl
	qemu-desktop
	ripgrep
	solaar
	spicetify-cli
	spotify
	stow
	ttf-jetbrains-mono
	ttf-nerd-fonts-symbols-1000-em
	unzip
	virt-manager
	vlc
	wmctrl
	wob
	xclip-git
	xcolor
	xdg-user-dirs
	xdotool
	xinit
	zip
	zoxide
)

# $INSTALL_CMD ${packages[@]}

setup_bat () {
	bat cache --build
}

setup_docker () {
	sudo groupadd docker
	sudo usermod -aG docker $USER
	sudo systemctl enable --now docker.service containerd.service
}

setup_libinput_gestures () {
	sudo usermod -aG input $USER
}

setup_logiops () {
	sudo systemctl enable logid --now
}

setup_spicetify () {
	sudo chmod a+wr /opt/spotify
	sudo chmod a+wr /opt/spotify/Apps -R

	spicetify config current_theme catppuccin-mocha
	spicetify config color_scheme lavender
	spicetify config inject_css 1 replace_colors 1 overwrite_assets 1
	spicetify config extensions catppuccin-mocha.js

	spicetify apply
	spicetify update
}

setup_virtmanager () {
	sudo groupadd libvirt
	sudo usermod -aG libvirt $USER
	sudo systemctl enable libvirtd --now
}

"$@"
