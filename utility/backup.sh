#!/usr/bin/sh

# run with sudo access to the drive!

HOME_DIR="/home/anon"

CODE_DIR="${HOME_DIR}/code"
SCRIPTS_DIR="${HOME_DIR}/Scripts"
CONFIG_DIR="${HOME_DIR}/.config"

PASS_DIR="${HOME_DIR}/.pass"
SSH_DIR="${HOME_DIR}/.ssh"

DOCUMENTS_DIR="${HOME_DIR}/Documents"
MUSIC_DIR="${HOME_DIR}/Music"
VIDEOS_DIR="${HOME_DIR}/Videos"
SOFTWARE_DIR="${HOME_DIR}/Software"
TEMPLATES_DIR="${HOME_DIR}/Templates"

WEBSITE_DIR="${HOME_DIR}/Website"

echo "INFO: Backing up the following directories: "         \
     ${CODE_DIR} ${SCRIPTS_DIR} ${CONFIG_DIR} ${PASS_DIR}   \
     ${SSH_DIR} ${DOCUMENTS_DIR} ${MUSIC_DIR} ${VIDEOS_DIR} \
     ${SOFTWARE_DIR} ${TEMPLATES_DIR} ${WEBSITE_DIR}

DRIVE_MOUNT_LOCATION="/media/anon/portable-sandisk-2tb"

drive_info=`findmnt ${DRIVE_MOUNT_LOCATION}`
if [ -z "${drive_info}" ]; then 
    echo "ERROR: drive isn't mounted - exiting."; 
    exit 1
fi

DRIVE_BACKUP_DIR="${DRIVE_MOUNT_LOCATION}/backup/home/austin"

backup() {
    dest=${1}
    src=${2}
    sudo rsync -ah --progress "${src}" "${dest}"
}

sudo mkdir -pv "${DRIVE_BACKUP_DIR}"

backup "${DRIVE_BACKUP_DIR}/" "${TEMPLATES_DIR}"
backup "${DRIVE_BACKUP_DIR}/" "${CODE_DIR}"
backup "${DRIVE_BACKUP_DIR}/" "${SCRIPTS_DIR}"
backup "${DRIVE_BACKUP_DIR}/" "${CONFIG_DIR}"
backup "${DRIVE_BACKUP_DIR}/" "${PASS_DIR}"
backup "${DRIVE_BACKUP_DIR}/" "${SSH_DIR}"
backup "${DRIVE_BACKUP_DIR}/" "${DOCUMENTS_DIR}"
backup "${DRIVE_BACKUP_DIR}/" "${MUSIC_DIR}"
backup "${DRIVE_BACKUP_DIR}/" "${VIDEOS_DIR}"
backup "${DRIVE_BACKUP_DIR}/" "${SOFTWARE_DIR}"
backup "${DRIVE_BACKUP_DIR}/" "${WEBSITE_DIR}"

echo "INFO: backup complete - exiting."
