#!/usr/bin/sh

WOBSOCK=$XDG_RUNTIME_DIR/wob.sock
WOB="wob                         \
	--height 36                  \
	--padding 0                  \
	--anchor bottom              \
	--margin 64                  \
	--border-color #11111bff     \
	--background-color #11111bff \
	--bar-color #89b4faff"

init () {
	rm -f $WOBSOCK && mkfifo $WOBSOCK && tail -f $WOBSOCK | $WOB
}

brightness () {
	brightnessctl set $1 -m
	# brightnessctl set $1 -m | cut -f4 -d, | sed s/%// > $WOBSOCK
}

brightness_increase () {
	brightness "5%+"
}

brightness_decrease () {
	brightness "5%-"
}

volume () {
	pamixer $1
	local vol=`pamixer --get-volume`
	if $(pamixer --get-mute); then
		vol=0
	fi
	# echo $vol > $WOBSOCK
}

volume_increase () {
	volume "--unmute --increase 2"
}

volume_decrease () {
	volume "--unmute --decrease 2"
}

volume_mute () {
	volume "--toggle-mute"
}

"$@"
