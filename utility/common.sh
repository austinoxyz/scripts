#!/bin/bash

# Usage fatal_script_error [message]
fatal_script_error() {
    if [ $# -ne 1 ]; then exit 1; fi
    echo "$1" >&2
    notify-send --urgency=critical --expire-time=2000 --category="script-error" "$1"
    exit 1
}

# Usage load_dmenu_config
load_dmenu_config() {
    dmenu_config=${XDG_CONFIG_HOME:-$HOME/.config}/dmenu
    if [ ! -e "${dmenu_config}" ]; then
        fatal_script_error "dmenu config not found at '$(dmenu_config)'"
    fi
    . ${dmenu_config}
}
