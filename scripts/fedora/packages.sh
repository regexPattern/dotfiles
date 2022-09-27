#!/usr/bin/sh

sudo dnf -y install dnf-plugins-core

# sudo dnf -y copr enable elxreno/libinput-gestures
sudo dnf -y copr enable mamg22/nsxiv
sudo dnf -y copr enable navneet/dragon-drop
sudo dnf -y copr enable notahat/pamixer
sudo dnf -y copr enable tokariew/glow

packages=(
	bat
	bluez
	dragon-drop
	exa
	fd-find
	firefox
	fish
	fzf
	git-delta
	glow
	golang
	hyperfine
	jetbrains-mono-fonts
	kitty
	# libinput-gestures
	lxappearance
	mpv
	neofetch
	nodejs
	nsxiv
	pamixer
	playerctl
	python3-pip
	ripgrep
	stow
	util-linux-user
	zoxide
)

sudo dnf -y install ${packages[@]}

# env CGO_ENABLED=0 go install -ldflags="-s -w" github.com/gokcehan/lf@latest }
