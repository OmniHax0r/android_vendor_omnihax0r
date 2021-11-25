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

ifeq ($(TARGET_PRIVATE_BUILD),true)

## ADD PRIVATE ASSETS HERE NOT TO BE INCLUDED IN PUBLIC BUILDS. DO NOT FORGET to .gitignore!!!
include $(CLEAR_VARS)

endif

endif

include $(call all-makefiles-under,$(LOCAL_PATH))
