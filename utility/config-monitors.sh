#!/bin/sh
xrandr_args="--mode 1920x1080 --brightness 1 --gamma 1:1:1"
nmonitors=`python3 -c "import subprocess;print(len([l.split()[0] for l in subprocess.check_output(['xrandr']).decode('utf-8').splitlines() if ' connected ' in l]))"`
if [ ${nmonitors} -eq 2 ]; then
    xrandr --output DP-0 --primary --left-of DP-4 --rate 144.00 ${xrandr_args} \
           --output DP-4 --crtc 1                 --rate  60.00 ${xrandr_args}
else
    xrandr --output DP-0 --primary --rate 144.00 ${xrandr_args}
fi
