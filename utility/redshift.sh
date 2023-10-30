#!/usr/bin/sh

if [ $# -ne 1 ]; then
    echo "Invalid number of arguments." >&2 && exit;
fi

gamma=''
brightness=''
case $1 in 
    "on")
        gamma="0.9:0.9:0.9"
        brightness="0.9" ;;
    "off")
        gamma="1:1:1"
        brightness="1" ;;
    *)
        echo "Unknown option '$1'; choices are 'on', and 'off'." >&2 && exit 1 ;;
esac

xrandr --output DP-0 --primary --left-of DP-4 --mode 1920x1080 --rate 144.00 --brightness ${brightness} --gamma ${gamma} --output DP-4 --mode 1920x1080 --rate 60.00 --brightness ${brightness} --gamma ${gamma} --crtc 1

