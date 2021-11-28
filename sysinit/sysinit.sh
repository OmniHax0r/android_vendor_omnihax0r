#!/system/bin/sh

export PATH=/sbin:/system/sbin:/system/bin:/system/xbin:/vendor/bin:/vendor/xbin

for script in /system/etc/init.d/*; do
    
    if [ -x $script ]; then
        
        /system/bin/log -t sysinit Running $script
        $script >> /dev/null 2>&1 &
    
    fi

done
