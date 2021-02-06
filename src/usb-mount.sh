#!/bin/bash

err_report() {
  echo "errexit on line $(caller)" >&2
}

trap err_report ERR

# This script is called from our systemd unit file to mount or unmount
# a USB drive.

# logger 1 - "$1"
# logger 2 - "$2"
# exit 0

echo_() {
    # echo "$1" | /usr/bin/tee /dev/tty | logger
    MSG="$(date +%N): $1"
    logger "$MSG"
}

usage()
{
    echo_ "Usage: $0 {add|remove} device_name (e.g. sdb1)"
    exit 1
}

if [[ $# -ne 2 ]]; then
    usage
fi

ACTION=$1
DEVBASE=$2
DEVICE="/dev/${DEVBASE}"

# echo_ "ACTION - ${ACTION}; DEVBASE - ${DEVBASE}; DEVICE - ${DEVICE}"
# mkdir -p /media/max

if [[ "${DEVBASE}" = "" ]]; then
    # echo_ "Empty \$DEVBASE; \$ACTION $ACTION, \$DEVICE $DEVICE"
    exit
fi

# See if this drive is already mounted, and if so where
MOUNT_POINT=$(/bin/mount | /bin/grep ${DEVICE} | /usr/bin/awk '{ print $3 }')

do_mount()
{
    if [[ -n ${MOUNT_POINT} ]]; then
        echo_ "Warning: ${DEVICE} is already mounted at ${MOUNT_POINT}"
        # exit 1
        exit
    fi

    # Get info for this drive: $ID_FS_LABEL, $ID_FS_UUID, and $ID_FS_TYPE
    eval $(/sbin/blkid -o udev ${DEVICE})

    # Figure out a mount point to use
    LABEL=${ID_FS_LABEL}
    if [[ -z "${LABEL}" ]]; then
        LABEL=${DEVBASE}
    elif /bin/grep -q " /media/max/${LABEL} " /etc/mtab; then
        # Already in use, make a unique one
        LABEL+="-${DEVBASE}"
    fi

    if [[ "${LABEL}" =~ ^(EFI2|Root2)$ ]]; then
        echo_ "Skip label: ${LABEL}"
        exit
    else
        echo_ "OK. Processing ${LABEL}"
    fi

    MOUNT_POINT="/media/max/${LABEL}"

    # echo_ "Mount point: ${MOUNT_POINT}"

    /bin/mkdir -p "${MOUNT_POINT}"

    # Global mount options
    OPTS="rw,relatime"

    # File system type specific mount options
    if [[ ${ID_FS_TYPE} == "vfat" ]]; then
        OPTS+=",users,gid=100,umask=000,shortname=mixed,utf8=1,flush"
    fi

    if ! /bin/mount -o ${OPTS} ${DEVICE} ${MOUNT_POINT}; then
        echo_ "Error mounting ${DEVICE} (status = $?)"
        /bin/rmdir ${MOUNT_POINT}
        exit 1
    fi

    echo_ "**** Mounted ${DEVICE} at ${MOUNT_POINT} ****"
}

do_unmount()
{
    if [[ -z ${MOUNT_POINT} ]]; then
        echo_ "Warning: ${DEVICE} is not mounted"
    else
        /bin/umount -l "${DEVICE}"
        echo_ "**** Unmounted ${DEVICE}"
    fi

    # Delete all empty dirs in /media that aren't being used as mount
    # points. This is kind of overkill, but if the drive was unmounted
    # prior to removal we no longer know its mount point, and we don't
    # want to leave it orphaned...
    for f in /media/max/* ; do
        if [[ -n $(/usr/bin/find "$f" -maxdepth 0 -type d -empty) ]]; then
            if ! /bin/grep -q " $f " /etc/mtab; then
                echo_ "**** Removing mount point $f"
                /usr/bin/rmdir "$f" >/dev/null 2>&1
            fi
        fi
    done
}

case "${ACTION}" in
    "add" )
        do_mount
        ;;
    "remove" )
        do_unmount
        ;;
    * )
        usage
        ;;
esac
