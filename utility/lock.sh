#!/usr/bin/sh
# ~/Scripts/utility/lock.sh

screenlock_file="${XDG_CACHE_HOME:-/home/austin/.cache}/screenlock.png"
grim -s 1.5 -l 0 "${screenlock_file}"
magick "${screenlock_file}" -scale 20% -blur 0x2 -resize 200% "${screenlock_file}"
hyprlock
