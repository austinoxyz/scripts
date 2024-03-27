#!/usr/bin/sh

if [ $# -gt 1 ]; then 
    echo "Too many arguments to 'random-wallpaper.sh'" && exit 1
fi

notify='no'
if [ "$#" = "1" ]; then 
    if [ "$1" = "notify" ]; then
        notify='yes'
    else
        echo "Unrecognized option to 'random-wallpaper.sh'" && exit 1
    fi
fi

if [ -z "${WALLPAPERS_DIR}" ]; then
    echo "No env var WALLPAPERS_DIR." && exit 1
fi

if [ ! -d "${WALLPAPERS_DIR}" ]; then
    echo "No directory found at '${WALLPAPERS_DIR}'." && exit 1
fi

genzathurarc=''
if [ -e "${WALSCRIPTS_DIR}/genzathurarc" ]; then
    genzathurarc="-o ${WALSCRIPTS_DIR}/genzathurarc"
fi

wallpaper_file="$(ls ${WALLPAPERS_DIR} | shuf -n 1)"

if [ "$notify" = "yes" ]; then
    notify-send ${wallpaper_file} -t 5000
fi

#wal -s -t -i ${WALLPAPERS_DIR}/${wallpaper_file} ${genzathurarc} --saturate 0.85 -b "#323232" > /dev/null 2>&1
feh --bg-fill --randomize ~/Pictures/Wallpapers/
