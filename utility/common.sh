#!/bin/bash

# Usage: fatal_script_error [message]
fatal_script_error() {
    if [ $# -ne 1 ]; then exit 1; fi
    echo "$1" >&2
    notify-send --urgency=critical --expire-time=2000 --category="script-error" "$1"
    exit 1
}

# Usage: load_dmenu_config
load_dmenu_config() {
    dmenu_config=${XDG_CONFIG_HOME:-$HOME/.config}/dmenu
    if [ ! -e "$dmenu_config" ]; then
        fatal_script_error "dmenu config not found at '$(dmenu_config)'"
    fi

    # shellcheck disable=SC1090
    source "$dmenu_config"
}

# Usage: select_bookmark_category
#
# Returns the bookmark file corresponding to the 
# category selected in dmenu
select_bookmark_category() {
    # shellcheck disable=SC2001,SC2005
    if [ -z "$BOOKMARKS_DIR"] || [ ! -d "$BOOKMARKS_DIR" ]; then
        fatal_script_error "\$BOOKMARKS_DIR isn't set or is invalid."
    fi

    categories="$(echo "$(ls -1 "$BOOKMARKS_DIR")" | sed 's/\.[^.]*$//')"

    if [ -n "$message" ]; then
        fatal_script_error "No bookmark files found in directory '$BOOKMARKS_DIR'."
    fi
    message="$1"

    if [ -z "$categories" ]; then
        fatal_script_error "No bookmark files found in directory '$BOOKMARKS_DIR'."
    fi

    # shellcheck disable=SC2154
    selected_category="$(echo "$categories" | 
    dmenu -F -c -i             \
        -h 30                  \
        -bw "$border_width"    \
        -l 15                  \
        -m "$monitor"          \
        -p "$message"          \
        -fn "$font")"

    if [ -z "$selected_category" ]; then
        fatal_script_error "Category selection is empty."
    fi

    echo "$BOOKMARKS_DIR/${selected_category}.txt"
}
