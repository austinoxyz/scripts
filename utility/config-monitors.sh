#!/bin/sh
xrandr --output DP-0 --primary --left-of DP-4 \
           --mode 1920x1080 --rate 144.00 --brightness 1 --gamma 1:1:1 \
       --output DP-4 --crtc 1 \
           --mode 1920x1080 --rate  60.00 --brightness 1 --gamma 1:1:1 
