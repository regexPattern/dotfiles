#!/usr/bin/sh

# This script sets my fstab file so my secondary hard drive `DRIVE` gets
# mounted on startup so my secondary hard drive `/dev/sda1` gets mounted on
# startup on the `TARGET_DIR` directory.

# https://confluence.jaytaala.com/display/TKB/Mount+drive+in+linux+and+set+auto-mount+at+boot

DRIVE="/dev/sda1"
TARGET_DIR="/media/data"
FSTAB="/etc/fstab"

UUID=`sudo blkid "$DRIVE" \
	| tr ' ' '\n'               \
	| grep "^UUID"              \
	| cut -d \" -f2`

if ! grep -q $UUID $FSTAB; then
	drive_name=`basename $DRIVE`
	filesystem_type=`lsblk -f | grep $drive_name | awk '{print $2}'`

	if [ -z $filesystem_type ]; then
		exit 1
	fi

	printf "# %s\nUUID=%s\t%s\t%s\tdefaults\t0\t0\n" \
		$DRIVE $UUID $TARGET_DIR $filesystem_type    \
		| sudo tee -a $FSTAB
fi

