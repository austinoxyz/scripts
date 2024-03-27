#!/bin/bash

# shellcheck disable=SC1090
source "${SCRIPTS}/utility/common.sh"
load_dmenu_config

ignored_devs_file="${XDG_STATE_HOME:-$HOME/.local/state}/storage-devices/ignored.txt"
devs_file="${XDG_STATE_HOME:-$HOME/.local/state}/storage-devices/devices.txt"
cache_file="${XDG_STATE_HOME:-$HOME/.local/state}/storage-devices/cache.txt"

# Lists all devs and partitions
list_all_devices() {
    lsblk -rno TYPE,PARTUUID,NAME,LABEL,SIZE | grep "part" --color=never | cut -f2-5 -d' '
}

# Filters devices by an `ignored.txt `
list_nonignored_devices() {
    filtered_lines=""
    while read -r line; do
        if ! grep -q "$(echo "$line" | cut -f1 -d' ')" "$ignored_devs_file"; then
            echo "$line" | cut -f1-4 -d' '
        fi
    done < <(list_all_devices)
}

list_nonignored_devices > "$cache_file"

selection=$(list_nonignored_devices | cut -f2- -d' ' | 
    dmenu -i -n -c                  \
        -p "Select storage device:" \
        -bw "$border_width"         \
        -g 1                        \
        -h 25                       \
        -l 6                        \
        -m "$monitor"               \
        -fn "$font")

if [ -z "$selection" ]; then
    exit 0
fi

selected_device_line=`grep "$selection" "$cache_file"`
dev_uuid=`echo "$selected_device_line" | cut -f1 -d' '`
dev_listing=`grep "$dev_uuid" "$devs_file"`

if [ -z "$dev_listing" ]; then
    echo "Device [$dev_uuid] not in '$devs_file'."
    echo "UNIMPLEMENTED: dmenu to specify pathname"
    exit 0
fi

dev_id=$(echo "$selected_device_line" | cut -f2 -d' ')
mountpath=$(echo "$dev_listing" | cut -f2 -d' ')

echo "dev_id: $dev_id"
echo "mountpath: $mountpath"

if [ -z "$mountpath" ]; then
    notify-send -t 2000 "ERROR" "No mouthpath specified in '$devs_file'"
    exit 0
fi

dev_label=$(echo "$selected_device_line" | cut -f3 -d' ')

if ! grep -qs "$mountpath" /proc/mounts; then
    notify-send --expire-time 2000 "Device mounted." "Mounted device '$dev_label' to '$dev_id'."
    mount "$dev_id" "$mountpath"
else
    notify-send --expire-time 2000 "Device unmounted." "Unmounted device '$dev_label' from '$dev_id'."
    umount -f "$dev_id"
fi

