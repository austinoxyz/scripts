#!/bin/bash
source ${SCRIPTS}/utility/common.sh
load_dmenu_config

selected_bookmark="$(cat ${BOOKMARKS_DIR}/* | dmenu -F -c -i \
    -h 30                                                   \
    -bw $border_width                                       \
    -l 15                                                   \
    -m $monitor                                             \
    -p "select site:"                                       \
    -fn $font)"

[ -n "$selected_bookmark" ] && firefox -url $selected_bookmark
