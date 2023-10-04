#!/bin/sh
. ${XDG_CONFIG_HOME:-$HOME/.config}/dmenu

cmd_out=${XDG_DATA_HOME:-$HOME/.local/share}/apps/launch_cmd_stdout
cmd_err=${XDG_DATA_HOME:-$HOME/.local/share}/apps/launch_cmd_stderr

cmd_to_run="$(. ~/.bash_aliases && echo | dmenu -c \
    -h 30                                          \
    -bw $border_width                              \
    -fn $font                                      \
    -m $monitor                                    \
    -p "enter cmd:")"

[ ! -z "$cmd_to_run" ] && bash -i -c "$cmd_to_run" >$cmd_out 2>$cmd_err
