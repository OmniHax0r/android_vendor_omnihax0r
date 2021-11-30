#!/system/bin/sh

MODDIR=${0%/*}

PATH=/system/bin:/sbin:/sbin/.core/busybox:/system/xbin

until [[ $(getprop sys.boot_completed) = 1 ]] && [[ $(getprop dev.bootcomplete) = 1 ]] && [[ $(getprop service.bootanim.exit) = 1 ]] && [[ $(getprop init.svc.bootanim) = stopped ]]; do

    sleep 1

done

sleep 4

if [[ $(getprop persist.developer.autohide) != 1 ]] && [[ $(getprop persist.developer.autohide) != 0 ]]; then

  setprop persist.developer.autohide 1

fi

if [[ $(getprop persist.auto.data) != 1 ]] && [[ $(getprop persist.auto.data) != 0 ]]; then

  setprop persist.auto.data 1

fi

if [[ $(getprop persist.auto.wifi) != 1 ]] && [[ $(getprop persist.auto.wifi) != 0 ]]; then

  setprop persist.auto.wifi 1

fi

if [[ $(getprop persist.auto.location) != 1 ]] && [[ $(getprop persist.auto.location) != 0 ]]; then

  setprop persist.auto.location 1

fi

if [[ $(getprop persist.disable.airplane) != 1 ]] && [[ $(getprop persist.disable.airplane) != 0 ]]; then

  setprop persist.disable.airplane 1

fi

sleep 4

if [[ $(getprop persist.disable.airplane) = 1 ]]; then

  settings put global airplane_mode_on 0

  sleep 0.5

  am broadcast -a android.intent.action.AIRPLANE_MODE

fi

sleep 0.5

if [[ $(getprop persist.auto.data) = 1 ]]; then

  svc data enable

fi

sleep 0.5

if [[ $(getprop persist.auto.wifi) = 1 ]]; then

  svc wifi enable

fi

sleep 0.5

if [[ $(getprop persist.auto.location) = 1 ]]; then

  settings put secure location_mode 3

fi

if [[ $(getprop persist.developer.autohide) = 1 ]]; then

  settings put global development_settings_enabled 0

fi

exit 0
