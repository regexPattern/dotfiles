# vim: ft=sh

session=${1:-awesome}

case $session in
	awesome)
		xset -dpms
		xset s off

		xrandr --output eDP-1 --right-of DP-1
		xrdb -load $HOME/.Xresources
		picom --experimental-backends &
		libinput-gestures-setup start &

		xinput set-prop "pointer:Logitech MX Master 3" "libinput Natural Scrolling Enabled" 0
		xinput set-prop "pointer:DELL07EC:00 06CB:7E92 Touchpad" "libinput Tapping Enabled" 1
		xinput set-prop "pointer:DELL07EC:00 06CB:7E92 Touchpad" "libinput Natural Scrolling Enabled" 1

		exec awesome
		;;
	plasma)
		export DESKTOP_SESSION=plasma
		exec startplasma-x11
		;;
	i3)
		i3
		;;
esac
