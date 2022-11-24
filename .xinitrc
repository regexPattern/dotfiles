# vim: ft=sh

xset -dpms
xset s off

# picom --experimental-backends &
# libinput-gestures-setup start

xrandr --output eDP-1 --right-of DP-1
xinput set-prop "pointer:Logitech MX Master 3" "libinput Natural Scrolling Enabled" 0
xinput set-prop "pointer:DELL07EC:00 06CB:7E92 Touchpad" "libinput Tapping Enabled" 1
xinput set-prop "pointer:DELL07EC:00 06CB:7E92 Touchpad" "libinput Natural Scrolling Enabled" 1

exec dwm
