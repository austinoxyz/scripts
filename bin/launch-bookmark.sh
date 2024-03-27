#!/bin/bash

# shellcheck disable=SC1090
source ${SCRIPTS:-$HOME/Scripts}/utility/common.sh
load_dmenu_config

bookmarks_file=`select_bookmark_category`

if [ -z "$bookmarks_file" ]; then
    # error message already handled in `select_bookmark_file`
    exit 1; 
fi

selected_bookmark="$(cat ${bookmarks_file} | dmenu -F -c -i \
    -h 30                                                   \
    -bw ${border_width}                                     \
    -l 15                                                   \
    -m ${monitor}                                           \
    -p "select site:"                                       \
    -fn ${font})"

# for some reason when selecting multiple bookmarks, wc is counting 1 as 1, 2 as 3, 3 as 4, and so on.
n_selected=$(echo $selected_bookmark | wc --words - | cut -d' ' -f 1)
[ "$n_selected" -lt 2 ] && [ ! -z "$selected_bookmark" ] && firefox -url $selected_bookmark; exit 0

bookmark_array=$(IFS=' ' read -r -a bookmark_array <<< "$selected_bookmark")
for element in "${bookmark_array[@]: 0: -1}"; do firefox -url $selected_bookmark; done
