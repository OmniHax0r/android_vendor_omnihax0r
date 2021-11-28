#Include public assets in ROM

TARGET_PUBLIC_BUILD := true

PRODUCT_SOONG_NAMESPACES += \
    vendor/omnihax0r

# Prebuilt APPs
PRODUCT_PACKAGES += \
	MagiskManager \
	omnihax0r-overlays \
	CallRecorder

# Privledged APP Perms
PRODUCT_COPY_FILES += \
	vendor/omnihax0r/permissions/privapp-permissions-com.github.axet.callrecorder.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/privapp-permissions-com.github.axet.callrecorder.xml

# Default APP Perms
PRODUCT_COPY_FILES += \
	vendor/omnihax0r/default-permissions/callrecorder-permissions.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/default-permissions/callrecorder-permissions.xml

# HID USB Gadget file descriptors 
PRODUCT_COPY_FILES += \
	vendor/omnihax0r/hid/keyboard-descriptor.bin:$(TARGET_COPY_OUT_SYSTEM)/etc/keyboard-descriptor.bin \
	vendor/omnihax0r/hid/mouse-descriptor.bin:$(TARGET_COPY_OUT_SYSTEM)/etc/mouse-descriptor.bin \
	vendor/omnihax0r/hid/init.hids.rc:$(TARGET_COPY_OUT_SYSTEM)/etc/init/init.gadgets.rc

# SELinux Polices
BOARD_PLAT_PRIVATE_SEPOLICY_DIR += vendor/omnihax0r/sepolicy/private
