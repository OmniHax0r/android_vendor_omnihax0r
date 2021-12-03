LOCAL_PATH := $(call my-dir)

# custom recovery path, prebuilt recovery must be downloaded here
# path can NOT be changed (w/o changing build/make, too) !

# build/make must be patched!!! Blame omni team for rejecting custom mkbootimg patches
# https://github.com/Geofferey/omni_android_build/commit/1d87fdfb8946ffc79f83d77cb5014ea4ea7bf81d
# extendrom modified for OmniHax0r builds
# https://github.com/Geofferey/android_vendor_extendrom

ROOT_BOOT_BIN := $(OUT_DIR)/.magisk/root_boot.sh
BOARD_CUSTOM_BOOTIMG := true

# BOOT.IMG
ifeq ($(BOARD_MAGISK_INIT),true)
$(INSTALLED_BOOTIMAGE_TARGET): $(MKBOOTIMG) $(AVBTOOL) $(INTERNAL_BOOTIMAGE_FILES) $(BOARD_AVB_BOOT_KEY_PATH)
	$(call pretty,"Target boot image: $@")
	$(hide) $(MKBOOTIMG) $(INTERNAL_BOOTIMAGE_ARGS) $(INTERNAL_MKBOOTIMG_VERSION_ARGS) $(BOARD_MKBOOTIMG_ARGS) --output $@
	@echo "++++  PRE-ROOTing BOOT image!!!  ++++"
	MAGISK_TARGET_ARCH=arm64 $(ROOT_BOOT_BIN) $@
	$(hide) $(call assert-max-image-size,$@,$(call get-hash-image-max-size,$(BOARD_BOOTIMAGE_PARTITION_SIZE)))
	@echo "++++  Add hash footer to BOOT image  ++++"
	$(hide) $(AVBTOOL) add_hash_footer \
          --image $(OUT_DIR)/.magisk/IMAGES/boot.img \
          --partition_size $(BOARD_BOOTIMAGE_PARTITION_SIZE) \
          --partition_name boot $(INTERNAL_AVB_BOOT_SIGNING_ARGS) \
          $(BOARD_AVB_BOOT_ADD_HASH_FOOTER_ARGS)
	@cp -v $(OUT_DIR)/.magisk/IMAGES/boot.img  $(PRODUCT_OUT)/boot.img
else
$(INSTALLED_BOOTIMAGE_TARGET): $(MKBOOTIMG) $(AVBTOOL) $(INTERNAL_BOOTIMAGE_FILES) $(BOARD_AVB_BOOT_KEY_PATH)
	$(call pretty,"Target boot image: $@")
	$(hide) $(MKBOOTIMG) $(INTERNAL_BOOTIMAGE_ARGS) $(INTERNAL_MKBOOTIMG_VERSION_ARGS) $(BOARD_MKBOOTIMG_ARGS) --output $@
	$(hide) $(call assert-max-image-size,$@,$(call get-hash-image-max-size,$(BOARD_BOOTIMAGE_PARTITION_SIZE)))
	@echo "++++  Add hash footer to BOOT image  ++++"
	$(hide) $(AVBTOOL) add_hash_footer \
          --image $@ \
          --partition_size $(BOARD_BOOTIMAGE_PARTITION_SIZE) \
          --partition_name boot $(INTERNAL_AVB_BOOT_SIGNING_ARGS) \
          $(BOARD_AVB_BOOT_ADD_HASH_FOOTER_ARGS)
endif

