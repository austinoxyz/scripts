#!/bin/bash
. ${SCRIPTS}/utility/common.sh
load_dmenu_config

bookmarks_file=`select_bookmark_file`

if [ -z "$bookmarks_file" ]; then
    exit 1; # error notification already handled in `select_bookmark_file`
fi

url="`xclip -out clip`"
url="${url##*://}"

if grep "^$url$" "$bookmarks_file"; then
    status_msg="Bookmark not added."
    msg="Bookmark already exists."
    urgency="critical" # abusing this for the color
else
    echo $url >> $bookmarks_file
    status_msg="Bookmark added."
    msg="$url" 
    urgency="normal"
fi

notify-send "$status_msg" "$msg" \
    -t 6000 \
    -u $urgency \
    -i $HOME/Pictures/icons/bookmark.png
