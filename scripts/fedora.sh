#!/usr/bin/sh

# TODO: Make packages not to be built if they are already installed. (This
# clearly is only for manually built pacakges).
#
# TODO: Docker setup.
#
# TODO: Finish settings Gnome settings. Also only trigger this if I'm using
# Gnome (which is probably the case in Fedora, but anyways).

print () {
	pritnf '>>> %s\n' $1
}

# Prelude {{{

DNF_CONFIG=/etc/dnf/dnf.conf

if ! grep -q fastestmirror $DNF_CONFIG; then
	echo 'fastestmirror=True' | sudo tee -a $DNF_CONFIG
fi

if ! grep -q max_parallel_downloads $DNF_CONFIG; then
	echo 'max_parallel_downloads=10' | sudo tee -a $DNF_CONFIG
fi

if ! grep -q defaultyes $DNF_CONFIG; then
	echo 'defaultyes=True' | sudo tee -a $DNF_CONFIG
fi

if ! grep -q keepcache $DNF_CONFIG; then
	echo 'keepcache=True' | sudo tee -a $DNF_CONFIG
fi

sudo dnf update

sudo dnf -y install \
	https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm \
	https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

sudo dnf groupupdate core

MY_HOSTNAME=carlos
CURR_HOSTNAME=/etc/hostname

if ! grep -v $MY_HOSTNAME $CURR_HOSTNAME; then
	sudo hostnamectl set-hostname $MY_HOSTNAME
fi

# }}}

# Drivers Setup {{{

sudo dnf groupupdate multimedia \
	--setop="install_weak_deps=False" \
	--exclude=PackageKit-gstreamer-plugin

sudo dnf groupupdate sound-and-video

# }}}

# Packages {{{

sudo dnf -y install dnf-plugins-core

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

# }}}

# Fonts {{{

mkdir -p $HOME/.local/share/fonts
curl -fL https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/JetBrainsMono/Ligatures/Regular/complete/JetBrains%20Mono%20Regular%20Nerd%20Font%20Complete.ttf \
	-o $HOME/.local/share/fonts/JetBrainsMono.ttf

# }}}

# Docker {{{

sudo dnf -y install dnf-plugins-core

sudo dnf config-manager \
	--add-repo          \
	https://download.docker.com/linux/fedora/docker-ce.repo

sudo dnf -y install \
	docker-ce       \
	docker-ce-cli   \
	containerd.io   \
	docker-compose-plugin

sudo groupadd docker
sudo usermod -aG docker $USER
sudo systemctl enable --now docker.service containerd.service

# }}}
