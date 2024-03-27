#!/bin/bash

# shellcheck disable=SC1090
source "${SCRIPTS}/utility/common.sh"
load_dmenu_config

bookmarks_file="$(select_bookmark_category "Which category to add to?")"

if [ -z "$bookmarks_file" ]; then
    # error message already handled in `select_bookmark_file`
    exit 1; 
fi

url="$(xclip -out clip)"
url="${url##*://}"

if grep "^$url$" "$bookmarks_file"; then
    status_msg="Bookmark not added."
    msg="Bookmark already exists."
    urgency="critical" # abusing this for the color
else
    # shellcheck disable=SC2154
    will_add_tag="$(printf "yes\nno" | 
    dmenu -F -c -i                   \
        -h 10                        \
        -bw "$border_width"          \
        -l 15                        \
        -m "$monitor"                \
        -p "add tags?"               \
        -fn "$font")"

    tags=""
    if [ "$will_add_tag" == "yes" ]; then
        adding_tags=true
        while [ $adding_tags ]; do
            tag="$(printf "$tags" |
            dmenu -c                   \
                -h 30                  \
                -bw "$border_width"    \
                -l 2                   \
                -g 2                   \
                -m "$monitor"          \
                -p "enter tag:"        \
                -fn "$font")"
            
            if [ -z "$tag" ]; then 
                break
            fi

            if [ -z "$tags" ]; then
                tags="$tag"
            else
                tags="$tags\n$tag"
            fi
        done
    fi

    if [ -n "$tags" ]; then
        tags="$(echo "$tags" | tr '\n' ' ')"
    fi

    notify-send "the tags" "$tags" -t 4000

    printf "%s %s" "$url" "$tags" >> "$bookmarks_file"

    status_msg="Bookmark added."
    msg="$url" 
    urgency="normal"
fi

notify-send "$status_msg" "$msg" \
    -t 6000       \
    -u "$urgency" \
    -i "$HOME/Pictures/icons/bookmark.png"

