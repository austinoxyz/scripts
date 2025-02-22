#!/usr/bin/bash

# shellcheck disable=SC1090
source "${SCRIPTS}/utility/common.sh"
load_dmenu_config

filename="/home/anon/Pictures/screenshot_$(date +"%d%m%Y_%H%M").png"

maim -s ${filename}

newfilename=''
newfilename=$(dmenu -h 30 -bw 2 -l 1 -m "$monitor" -F -c -i -n -p "name screenshot [leave empty for no]?")

if [ ! -z ${newfilename} ]; then
    mv ${filename} ${newfilename}
fi
