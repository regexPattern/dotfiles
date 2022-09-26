#!/usr/bin/sh

INSTALL_CMD="paru -S --needed --noconfirm"

PKGS=(
	acpi
	bluez
	bluez-utils
	dragon-drop
	exa
	fd
	fish
	fzf
	git-delta
	github-cli
	glow
	go
	htop-vim
	hyperfine
	imagemagick
	kitty
	lf
	lxappearance
	man-db
	man-pages
	neofetch
	nodejs
	noto-fonts
	noto-fonts-emoji
	npm
	nsxiv
	openssh
	pamixer
	pcmanfm-gtk3
	pfetch
	playerctl
	polkit
	python-pip
	ripgrep
	stow
	ttf-jetbrains-mono
	ttf-nerd-fonts-symbols-1000-em
	unzip
	vlc
	xdg-user-dirs
	zip
	zoxide
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

"$@"
