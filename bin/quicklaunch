#!/bin/sh
. ${XDG_CONFIG_HOME:-$HOME/.config}/dmenu
CONFIG_FNAME="${XDG_DATA_HOME:-$HOME/.local/share}/apps/whitelisted.txt"

# run dmenu and get selected_app
selected_app="$(cat $CONFIG_FNAME | \
    cut -d":" -f 1 |      \
    dmenu -i -n -c        \
        -g 2              \
        -bw $border_width \
        -h 25             \
        -l 6              \
        -m $monitor       \
        -p "select app:"  \
        -fn $font)"

if [ -n "$selected_app" ]; then
    _app_config="$(grep "^$selected_app" $CONFIG_FNAME)" 
    mode="$(echo $_app_config | cut -d":" -f 2)"
    name="$(echo $_app_config | cut -d":" -f 3)"
    case $mode in 
        "NORMAL")
            exec $name
            ;;
        "TERMINAL")
            exec $(cat ${XDG_CONFIG_HOME:-$HOME/.config}/term) -e $name
            ;;
        "SHELL")
            exec $name | ${SHELL:-"/bin/sh"} &
            ;;
        "WEBSITE")
            exec firefox -new-window $name
            ;;
        *)
            notify-send --expire-time=5000 --urgency=critical "invalid mode in \$XDG_DATA_HOME/apps/whitelisted.txt"
    esac
fi

