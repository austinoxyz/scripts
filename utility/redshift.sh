#!/usr/bin/sh

cache_file="${XDG_CACHE_HOME:-$HOME/.local/cache}/redshift"

gamma=""
brightness=""
redshift="$(cat $cache_file)"
if [ "$redshift" = "on" ]; then
    gamma="1:1:1"
    brightness="1" 
    echo "off" > $cache_file
else
    gamma="0.81:0.81:0.81"
    brightness="0.81" 
    echo "on" > $cache_file
fi

xrandr --output DP-0 --primary --left-of DP-4 \
           --mode 1920x1080 --rate 144.00 --brightness ${brightness} --gamma ${gamma} \
       --output DP-4 \
           --mode 1920x1080 --rate 60.00 --brightness ${brightness} --gamma ${gamma} #--crtc 1

