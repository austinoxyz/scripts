#!/bin/sh
. ${XDG_CONFIG_HOME:-$HOME/.config}/dmenu

search_query="$(echo | dmenu -c \
    -h 30                       \
    -bw $border_width           \
    -m $monitor                 \
    -p "search: "               \
    -fn $font)"

[ -n "$search_query" ] && firefox -search "$search_query"

