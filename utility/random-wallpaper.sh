#!/usr/bin/sh

if [ -z "${WALLPAPERS_DIR}" ]; then
    echo "No env var WALLPAPERS_DIR." && exit 1
fi

if [ ! -d "${WALLPAPERS_DIR}" ]; then
    echo "No directory found at '${WALLPAPERS_DIR}'." && exit 1
fi

genzathurarc=''
if [ -e "${WALSCRIPTS_DIR}/genzathurarc" ]; then
    genzathurarc="-o ${WALSCRIPTS_DIR}/genzathurarc"
fi

wal -i ${WALLPAPERS_DIR} ${genzathurarc} --saturate 0.85 -b "#323232" > /dev/null 2>&1
