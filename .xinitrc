# vim: ft=sh

# source /etc/X11/xinit/xinitrc-common

xset -dpms
xset s off

xrandr --output eDP-1 --right-of DP-1

xinput set-prop "pointer:Logitech MX Master 3" "libinput Natural Scrolling Enabled" 0
xinput set-prop "pointer:DELL07EC:00 06CB:7E92 Touchpad" "libinput Tapping Enabled" 1
xinput set-prop "pointer:DELL07EC:00 06CB:7E92 Touchpad" "libinput Natural Scrolling Enabled" 1

# picom --experimental-backends &
# libinput-gestures-setup start

exec dwm
