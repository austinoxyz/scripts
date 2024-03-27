#!/bin/sh

# $VPN_CONNECTED description:
# 0 - Disconnected
# 1 - Connected
# 2 - Blocked

state_file="${SCRIPTS}/state/vpn"

vpn_connected="$(cat ${state_file})"

echo -n "${vpn_connected}"

error_notif_title="Error in 'vpn.sh'"

if [ "$(mullvad version)" = "" ]; then
    notify-send --urgency=critical --expire-time=3500 --icon="${ICONS}/error.png" \
        "$error_notif_title" "mullvad isn't installed"
fi

status="$(mullvad status)"

if [ "${vpn_connected}" = "1" ]; then
    if [ "${status}" = "Disconnected" ]; then
        notify-send --urgency=critical --expire-time=3500 --icon="${ICONS}/error.png" \
            "${error_notif_title}" "vpn_connected=1 but mullvad status = Disconnected"
    else
        mullvad disconnect;
        echo "0" >${state_file}
    fi
elif [ "${vpn_connected}" = "0" ]; then
    if [ "${status}" != "Disconnected" ]; then
        notify-send --urgency=critical --expire-time=3500 --icon="${ICONS}/error.png" \
            "${error_notif_title}" "vpn_connected=0 but mullvad status != Disconnected"
    else
        mullvad connect;
        echo "1" >${state_file}
    fi
fi

vpn_connected="$(cat ${state_file})"
echo "-> ${vpn_connected}"

