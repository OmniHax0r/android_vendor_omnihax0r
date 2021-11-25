#!/bin/sh

for app in `./busybox-x86 --list`; do `ln -sf /system/xbin/busybox ${app}| cut -d ',' -f1`; done
