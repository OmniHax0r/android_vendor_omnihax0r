#Include public assets in ROM

TARGET_PUBLIC_BUILD := true

PRODUCT_SOONG_NAMESPACES += \
    vendor/omnihax0r

# Prebuilt APPs
PRODUCT_PACKAGES += \
	MagiskManager \
	omnihax0r-overlays \
	CallRecorder \
	AndLost \
	AndLostSMS \
	BBStats \
	NXPlayer

# Privledged APP Perms
PRODUCT_COPY_FILES += \
	vendor/omnihax0r/permissions/privapp-permissions-com.github.axet.callrecorder.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/privapp-permissions-com.github.axet.callrecorder.xml \
	vendor/omnihax0r/permissions/privapp-permissions-com.asksven.betterbatterystats.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/privapp-permissions-privapp-permissions-com.asksven.betterbatterystats.xml

# Default APP Perms
PRODUCT_COPY_FILES += \
	vendor/omnihax0r/default-permissions/callrecorder-permissions.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/default-permissions/callrecorder-permissions.xml \
	vendor/omnihax0r/default-permissions/androidlost-permissions.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/default-permissions/androidlost-permissions.xml \
	vendor/omnihax0r/default-permissions/andlostsms-permissions.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/default-permissions/andlostsms-permissions.xml \
	vendor/omnihax0r/default-permissions/bbstats-permissions.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/default-permissions/bbstats-permissions.xml

# Sysconfig
PRODUCT_COPY_FILES += \
	vendor/omnihax0r/sysconfig/andlost.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/sysconfig/andlost.xml \
	vendor/omnihax0r/sysconfig/andlostsms.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/sysconfig/andlostsms.xml

# HID USB Gadget file descriptors 
PRODUCT_COPY_FILES += \
	vendor/omnihax0r/hid/keyboard-descriptor.bin:$(TARGET_COPY_OUT_SYSTEM)/etc/keyboard-descriptor.bin \
	vendor/omnihax0r/hid/mouse-descriptor.bin:$(TARGET_COPY_OUT_SYSTEM)/etc/mouse-descriptor.bin \
	vendor/omnihax0r/hid/init.hids.rc:$(TARGET_COPY_OUT_SYSTEM)/etc/init/init.gadgets.rc

# SELinux Polices
BOARD_PLAT_PRIVATE_SEPOLICY_DIR += vendor/omnihax0r/sepolicy/private

# Private assets excluded in PUBLIC builds

ifeq ($(ROM_BUILDTYPE),PRIVATE)

## ADD PRIVATE ASSETS HERE NOT TO BE INCLUDED IN PUBLIC BUILDS. DO NOT FORGET to .gitignore!!!

$(call inherit-product-if-exists, vendor/omnihax0r/private/private.mk)

endif
