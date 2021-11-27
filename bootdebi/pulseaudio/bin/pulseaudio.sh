#!/system/bin/sh

export LD_LIBRARY_PATH=/system/etc/bootdebi/pulseaudio/lib:/system/apex/com.android.runtime.release/lib64

export HOME=/data/home/$(whoami)

export TMPDIR=$HOME

if ! [ -z $* ]; then

  /system/etc/bootdebi/pulseaudio/bin/pulseaudio $*

else

  /system/etc/bootdebi/pulseaudio/bin/pulseaudio -F /system/etc/bootdebi/pulseaudio/pulseaudio.conf

fi
