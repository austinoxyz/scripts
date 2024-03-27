#!/bin/bash

# shellcheck disable=SC1090
source "${SCRIPTS}/utility/common.sh"
load_dmenu_config

apps="${XDG_DATA_HOME:-$HOME/.local/share}/apps.txt"

# run dmenu and get selected_app
# shellcheck disable=SC2154
selected_app="$(cut "$apps" -d":" -f 1 |    
    dmenu -i -n -c               \
        -g 2                     \
        -bw "$border_width"      \
        -h 25                    \
        -l 6                     \
        -m "$monitor"            \
        -p "select app:"         \
        -fn "$font")"

if [ -n "$selected_app" ]; then
    _app_config="$(grep "^$selected_app" "$apps")" 
    name="$(echo "$_app_config" | cut -d":" -f 2)"
    mode="$(echo "$_app_config" | cut -d":" -f 3)"
    case "$mode" in 
        "BINARY")
            exec "$name"
            ;;
        "TERMINALAPP")
            exec "$(cat "${XDG_CONFIG_HOME:-$HOME/.config}/term")" -e "$name"
            ;;
        "SHELLSCRIPT")
            exec "$name" | ${SHELL:-"/bin/sh"} &
            ;;
        "WEBSITE")
            exec firefox -new-window "$name"
            ;;
        *)
            notify-send --expire-time=5000 --urgency=critical "invalid mode in \$XDG_DATA_HOME/apps/whitelisted.txt"
    esac
fi

