LOCAL_PATH := $(call my-dir)

ifeq ($(ROM_BUILDTYPE),PRIVATE)
TARGET_PRIVATE_BUILD := true
endif

ifeq ($(TARGET_PUBLIC_BUILD),true)

## ADD PUBLIC ASSETS HERE

# Osm0sis busybox
include $(CLEAR_VARS)
LOCAL_MODULE       := osm0sis_busybox
LOCAL_MODULE_TAGS  := optional
$(shell mkdir -p $(TARGET_OUT)/xbin)
$(shell cp -rf $(LOCAL_PATH)/osm0sis_busybox/* $(TARGET_OUT)/xbin/)

# bash prebuilt
include $(CLEAR_VARS)
LOCAL_MODULE       := bash_prebuilt
BASH_EXEC=    := bash
LOCAL_MODULE_TAGS  := optional
$(shell mkdir -p $(TARGET_OUT)/xbin)
$(shell mkdir -p $(TARGET_OUT_ETC)/bash)
$(shell cp $(LOCAL_PATH)/bash_prebuilt/bash $(TARGET_OUT)/xbin/)
$(shell cp $(LOCAL_PATH)/bash_prebuilt/bash.bashrc $(TARGET_OUT_ETC)/bash/bashrc)

# bootdebi
include $(CLEAR_VARS)
LOCAL_MODULE       := bootdebi
LOCAL_MODULE_TAGS  := optional
$(shell mkdir -p $(TARGET_OUT_ETC)/bootdebi/)
$(shell mkdir -p $(TARGET_OUT_ETC)/init.d)
$(shell mkdir -p $(TARGET_OUT)/xbin)
$(shell cp -rf $(LOCAL_PATH)/bootdebi/* $(TARGET_OUT_ETC)/bootdebi)
$(shell mv $(TARGET_OUT_ETC)/bootdebi/S999bootdebi $(TARGET_OUT_ETC)/init.d/)
$(shell mv $(TARGET_OUT_ETC)/bootdebi/pulseaudio/bin/pulseaudio.sh $(TARGET_OUT)/xbin/pulseaudio)
$(shell ln -sf /system/etc/bootdebi/scripts/bootdebi $(TARGET_OUT)/xbin/bootdebi)
$(shell ln -sf /system/etc/bootdebi/scripts/bootdebi_login $(TARGET_OUT)/xbin/login)
$(shell ln -sf /system/etc/bootdebi/scripts/bootdebi-config $(TARGET_OUT)/xbin/bootdebi-config)

# sysinit
include $(CLEAR_VARS)
LOCAL_MODULE := sysinit
LOCAL_MODULE_TAGS := optional
$(shell mkdir -p $(TARGET_OUT)/xbin)
$(shell mkdir -p $(TARGET_OUT_ETC)/init)
$(shell cp $(LOCAL_PATH)/sysinit/sysinit.sh $(TARGET_OUT)/xbin/sysinit)

ifeq ($(TARGET_BUILD_VARIANT),user)

$(shell cp $(LOCAL_PATH)/sysinit/sysinit-user.rc $(TARGET_OUT_ETC)/init/sysinit.rc)

endif

ifeq ($(TARGET_BUILD_VARIANT),eng)

$(shell cp $(LOCAL_PATH)/sysinit/sysinit-eng.rc $(TARGET_OUT_ETC)/init/sysinit.rc)

endif

ifeq ($(TARGET_BUILD_VARIANT),userdebug)

$(shell cp $(LOCAL_PATH)/sysinit/sysinit-eng.rc $(TARGET_OUT_ETC)/init/sysinit.rc)

endif

# chanfire's liveboot
include $(CLEAR_VARS)
LOCAL_MODULE       := chainfire_liveboot
LOCAL_MODULE_TAGS  := optional
$(shell mkdir -p $(TARGET_OUT)/exbin/)
$(shell mkdir -p $(TARGET_OUT)/exlib/)
$(shell mkdir -p $(TARGET_OUT_ETC)/init)
$(shell cp -rf $(LOCAL_PATH)/chainfire_liveboot/liveboot $(TARGET_OUT)/exbin)
$(shell cp -rf $(LOCAL_PATH)/chainfire_liveboot/liveboot-daemonize $(TARGET_OUT)/exbin)
$(shell cp -rf $(LOCAL_PATH)/chainfire_liveboot/liveboot.so $(TARGET_OUT)/exlib)
$(shell cp -rf $(LOCAL_PATH)/chainfire_liveboot/liveboot.sh $(TARGET_OUT)/xbin/liveboot)

#ifeq ($(TARGET_BUILD_VARIANT),user)

#$(shell cp -rf $(LOCAL_PATH)/chainfire_liveboot/liveboot.rc $(TARGET_OUT_ETC)/init)

#endif

#ifeq ($(TARGET_BUILD_VARIANT),eng)

#$(shell cp -rf $(LOCAL_PATH)/chainfire_liveboot/liveboot-eng.rc $(TARGET_OUT_ETC)/init/liveboot.rc)

#endif

#ifeq ($(TARGET_BUILD_VARIANT),userdebug)

#$(shell cp -rf $(LOCAL_PATH)/chainfire_liveboot/liveboot-eng.rc $(TARGET_OUT_ETC)/init/liveboot.rc)

#endif

# PDSSHD (persist droid sshd)
include $(CLEAR_VARS)
LOCAL_MODULE       := pdsshd
LOCAL_MODULE_TAGS  := optional
$(shell mkdir -p $(TARGET_OUT)/xbin)
$(shell mkdir -p $(TARGET_OUT)/exbin/)
$(shell mkdir -p $(TARGET_OUT_ETC)/init.d/)
$(shell cp $(LOCAL_PATH)/PDSSHD/60dropbear $(TARGET_OUT_ETC)/init.d)
$(shell cp $(LOCAL_PATH)/PDSSHD/pdsshd.conf $(TARGET_OUT_ETC))
$(shell cp $(LOCAL_PATH)/PDSSHD/dropbear $(TARGET_OUT)/xbin)
$(shell cp $(LOCAL_PATH)/PDSSHD/sftp-server.sh $(TARGET_OUT)/xbin/sftp-server)
$(shell cp $(LOCAL_PATH)/PDSSHD/pdsshd-toolkit $(TARGET_OUT)/xbin)
$(shell cp $(LOCAL_PATH)/PDSSHD/sftp-server $(TARGET_OUT)/exbin)
$(shell cp $(LOCAL_PATH)/PDSSHD/dropbearmulti $(TARGET_OUT)/exbin)
$(shell ln -sf /system/exbin/dropbearmulti $(TARGET_OUT)/exbin/dropbear)
$(shell ln -sf /system/exbin/dropbearmulti $(TARGET_OUT)/xbin/scp)
$(shell ln -sf /system/exbin/dropbearmulti $(TARGET_OUT)/xbin/dbclient)
$(shell ln -sf /system/exbin/dropbearmulti $(TARGET_OUT)/xbin/ssh)
$(shell ln -sf /system/exbin/dropbearmulti $(TARGET_OUT)/xbin/dropbearkey)
$(shell ln -sf /system/exbin/dropbearmulti $(TARGET_OUT)/xbin/dropbearconvert)

# wireless firmware
include $(CLEAR_VARS)
LOCAL_MODULE       := wireless_firmware
LOCAL_MODULE_TAGS  := optional
$(shell mkdir -p $(TARGET_OUT_ETC)/firmware/)
$(shell cp -rf $(LOCAL_PATH)/firmware/* $(TARGET_OUT_ETC)/firmware)

# magisk restore (requires custom extendrom preroot boot)
include $(CLEAR_VARS)
LOCAL_MODULE := magisk_restore
LOCAL_MODULE_TAGS := optional
$(shell mkdir -p $(TARGET_OUT_ETC)/restore)
$(shell cp -rf $(LOCAL_PATH)/magisk/setup.tar.gz $(TARGET_OUT_ETC)/restore/setup.tar.gz)

# NX Player libs (for chroot desktop access)
include $(CLEAR_VARS)
LOCAL_MODULE       := nxplayer_libs
LOCAL_MODULE_TAGS  := optional
$(shell mkdir -p $(TARGET_OUT)/app/NXPlayer/lib/)
$(shell cp -rf $(LOCAL_PATH)/proprietary/apps/NXPlayer/lib/* $(TARGET_OUT)/app/NXPlayer/lib)

endif

include $(call all-makefiles-under,$(LOCAL_PATH))
