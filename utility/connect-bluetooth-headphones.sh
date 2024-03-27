#!/usr/bin/sh

# Scripts/utility/connect-bluetooth-device.sh

usage="Usage: ./connect-bluetooth-device.sh device-addr [trust]\n\
         i.e. ./connect-bluetooth-device.sh E8:0B:CD:FE:AA:30\n\
          or  ./connect-bluetooth-device.sh E8:0B:CD:FE:AA:30 trust"

if [ "$#" -ge 3 ] | [ "$#" -eq 0 ]; then
    echo "Invalid number of arguments - need device mac and trust status" >&2
    exit 1
fi

dev_addr="${1}"
trust="${2}"
if [ "$trust" != "trust" ]; then
    trust=""
fi

echo -n "Attempting to connect to device [${dev_addr}]"
if [ ! -z "${trust}" ]; then
    echo "(with trust)..."
else echo "..."; fi 

echo -n "Disconnecting from current device if exists..."
disconnect_output=`bluetoothctl disconnect`
dev_noexist=`echo ${disconnect_output} | grep "Missing device address argument"`
successful_disconnect=`echo ${disconnect_output} | grep "Successful"`
if [ ! -z "${dev_noexist}" ]; then
    echo "no device."
elif [ ! -z "${successful_disconnect}" ]; then
    echo "successful."
else
    echo
    echo "ERROR: Failed to disconnect from current device." 1>&2
    exit 1
fi

paired=`bluetoothctl info "$dev_addr" | grep "Paired:" | grep "yes"`
if [ ! -z "$paired" ]; then
    echo "Already paired."
else
    echo -n "Attempting to pair..."
    pair_status=`bluetoothctl pair "$dev_addr" | grep "Successful`
    if [ ! -z "${pair_status}" ]; then

    if [ ! -z 
fi

bonded=`bluetoothctl info "$dev_addr" | grep "Bonded:" | grep "yes"`
if [ ! -z "$bonded" ]; then
    echo "Already bonded."
else
    echo -n "Attempting to bond..."
    successful_bond=`bluetoothctl bond "$dev_addr"`
fi

trusted=`bluetoothctl info "$dev_addr" | grep "Trusted:" | grep "yes"`
if [ ! -z "$trusted" ]; then
    echo "Already trusted."
else
    echo -n "Attempting to trust..."
    successful_trust=`bluetoothctl trust "$dev_addr"`
fi

connected=`bluetoothctl info "$dev_addr" | grep "Connected:" | grep "yes"`
if [ ! -z "$connected" ]; then
    echo "Already connected."
else
    echo -n "Attempting to connect..."
    successful_connect=`bluetoothctl connect "$dev_addr"`
fi

