LOCAL_PATH := $(call my-dir)

ifeq ($(ROM_BUILDTYPE),PRIVATE)
TARGET_PRIVATE_BUILD := true
endif

ifeq ($(TARGET_PUBLIC_BUILD),true)

## ADD PUBLIC ASSETS HERE
include $(CLEAR_VARS)

ifeq ($(TARGET_PRIVATE_BUILD),true)

## ADD PRIVATE ASSETS HERE NOT TO BE INCLUDED IN PUBLIC BUILDS. DO NOT FORGET to .gitignore!!!
include $(CLEAR_VARS)

endif

endif

include $(call all-makefiles-under,$(LOCAL_PATH))
