#!/bin/sh
. ${SCRIPTS:-$HOME/Scripts}/utility/common.sh
load_dmenu_config

search_query="$(echo | dmenu -c \
    -h 30                       \
    -bw $border_width           \
    -m $monitor                 \
    -p "search: "               \
    -fn $font)"

[ -n "$search_query" ] && firefox -search "$search_query"

