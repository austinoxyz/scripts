#!/bin/bash
. ${SCRIPTS}/utility/common.sh

load_dmenu_config

BOOKMARKS_DIR=${XDG_DATA_HOME:-$HOME/.local/share}/bookmarks

if [ ! -d ${BOOKMARKS_DIR} ]; then
    fatal_script_error "Bookmarks directory not found."
fi

categories="$(echo "$(ls -1 ${BOOKMARKS_DIR})" | sed 's/\.[^.]*$//')"

if [ -z "${categories}" ]; then
    fatal_script_error "No bookmark files found in directory '${BOOKMARKS_DIR}'."
fi

selected_category="$(echo "${categories}" | dmenu -F -c -i \
    -h 30                  \
    -bw ${border_width}    \
    -l 15                  \
    -m ${monitor}          \
    -p "select category:"  \
    -fn ${font})"

if [ -z ${selected_category} ]; then
    fatal_script_error "Category selection is empty."
fi

bookmarks_file=${BOOKMARKS_DIR}/${selected_category}.txt

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
