#!/usr/bin/env -S bash

cd ~

export XCURSOR_SIZE=24

export QT_QPA_PLATFORM=wayland
export QT_QPA_PLATFORMTHEME="qt5ct"

exec Hyprland
