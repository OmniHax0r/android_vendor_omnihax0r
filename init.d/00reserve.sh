#!/bin/sh

## Designed by Geofferey for OmniHax0r-11 on OnePlus 8T

## WARNING!!!: ################################
#
# reserve4 has very limited space on the op8t/7t (10MB)
# Use only to execute scripts and store .confs
# Scripts WILL survive userdata wipes BE CAREFUL!
# If need be use scripts with plenty of logic
# ALWAYS test thoughly BEFORE and AFTER a WIPE for use case
# Always use service.d for scripts you dont need to survive
#
##  DO NOT MODIFY FOOLS!!!! ####################

## NOTE: #####################################
# You must format reserve4 as ext4 manually before use
# Located at /dev/block/bootdevice/by-name/reserve4
# Always check if partition is zero'd before just in case
# You can use cat or a hex editor to read the data
############################################

RESERVE_PART=/dev/block/sde75
MOUNT_POINT=/mnt/reserve
MOUNT_OPS=ro
FS_TYPE=ext4
RESERVE_D=${MOUNT_POINT}/.android-reserve.d

if ! [ -d ${MOUNT_POINT} ]; then

  mkdir ${MOUNT_POINT}
  chmod 500 ${MOUNT_POINT}

fi

if ! blkid |grep -w "${RESERVE_PART}" |grep -q -w 'TYPE="'${FS_TYPE}'"'; then

  exit

fi

if ! mount |grep -q -w "${RESERVE_PART} on ${MOUNT_POINT}"; then

  mount -o ${MOUNT_OPS} ${RESERVE_PART} ${MOUNT_POINT} >> /dev/null 2>&1

fi

if ! [ -d ${RESERVE_D} ]; then

  mkdir ${RESERVE_D}

fi


if [ -d ${RESERVE_D} ]; then

  for script in ${RESERVE_D}/*; do

    sleep 1
    
    if [ -x $script ]; then
        
        /system/bin/log -t sysinit Running $script from ${RESERVE_D}
        $script >> /dev/null 2>&1 &

    fi

  done

fi
