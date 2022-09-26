#!/usr/bin/sh

sudo dnf -y install \
	https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm \
	https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm \
	dnf-plugins-core

sudo dnf config-manager \
	--add-repo \
	https://download.docker.com/linux/fedora/docker-ce.repo

sudo dnf -y copr enable elxreno/libinput-gestures
sudo dnf -y copr enable mamg22/nsxiv
sudo dnf -y copr enable navneet/dragon-drop
sudo dnf -y copr enable notahat/pamixer
sudo dnf -y copr enable tokariew/glow

packages=(
	bat
	bluez
	cmake
	containerd.io
	docker-ce
	docker-ce-cli
	docker-compose-plugin
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
	libinput-gestures
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
	xinput
	zoxide
)

sudo dnf -y install ${packages[@]}

install-lf() {
	env CGO_ENABLED=0 go install -ldflags="-s -w" github.com/gokcehan/lf@latest }

install-logiops() {
	sudo dnf -y install cmake libevdev-devel systemd-devel libconfig-devel gcc-c++
	local build_dir=`mktemp -d`
	git clone https://github.com/PixlOne/logiops $build_dir
	cd $build_dir && mkdir build && cd build
	cmake ..
	make
	sudo make install
}

# flatpak install flathub com.brave.Browser
# flatpak install flathub com.discordapp.Discord
# flatpak install flathub org.gimp.GIMP
# flatpak install flathub com.obsproject.Studio
# flatpak install flathub com.spotify.Client
