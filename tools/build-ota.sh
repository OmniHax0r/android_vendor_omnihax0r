## Copy me to root of build directory

START_TIME=$(date)
export START_TIME=${START_TIME}

if [ -z ${SIGN_TARGET_FILES_BIN} ]; then

  SIGN_TARGET_FILES_BIN=out/host/linux-x86/bin/sign_target_files_apks

fi

if [ -z ${OTA_TARGET_FILES_BIN} ]; then

  OTA_TARGET_FILES_BIN=out/host/linux-x86/bin/ota_from_target_files

fi

if [ -z ${TARGET_PRODUCT} ]; then

    echo ""
    echo "You must set a product first!"
    echo "Run: 'breakfast TARGET_PRODUCT'"
    exit 0

fi

if [ ! -z ${CLEAN_BUILD} ]; then

    source build/envsetup.sh
    make clean && make clobber
    sleep 10

fi

DEVICE=$(echo ${TARGET_PRODUCT} |cut -d '_' -f2)

if [ -z ${OTA_UPDATE_DIR} ]; then

  OTA_UPDATE_DIR=/var/www/html/${DEVICE}

fi

echo ""

echo "Building for: "${DEVICE}
echo ${START_TIME}
DATE=$(date +%Y%m%d%H%M)
export OTA_BUILD_DATE=${DATE}

echo ""

source build/envsetup.sh

breakfast ${DEVICE}

echo OmniHax0r-11-${OTA_BUILD_DATE}-${DEVICE}-${ROM_BUILDTYPE}

mka target-files-package otatools

${SIGN_TARGET_FILES_BIN} -o -d .signing-keys/ --prebuilts_path presign-img/ $OUT/obj/PACKAGING/target_files_intermediates/*-target_files-*.zip $OUT/signed-target_files.zip

echo ""

if [ ! -d ${OTA_UPDATE_DIR} ]; then

    mkdir -p ${OTA_UPDATE_DIR}

fi

${OTA_TARGET_FILES_BIN} -k .signing-keys/releasekey ${OUT}/signed-target_files.zip ${OTA_UPDATE_DIR}/OmniHax0r-11-${OTA_BUILD_DATE}-${DEVICE}-${ROM_BUILDTYPE}.zip

md5sum ${OTA_UPDATE_DIR}/OmniHax0r-11-${OTA_BUILD_DATE}-${DEVICE}-${ROM_BUILDTYPE}.zip > ${OTA_UPDATE_DIR}/OmniHax0r-11-${OTA_BUILD_DATE}-${DEVICE}-${ROM_BUILDTYPE}.zip.md5sum

END_TIME=$(date)
export END_TIME=${END_TIME}

echo ""

echo "Completed "OmniHax0r-11-${OTA_BUILD_DATE}-${DEVICE}-${ROM_BUILDTYPE}

echo "Build started on "${START_TIME}

echo "Build ended "${END_TIME}

unset START_TIME
unset OTA_BUILD_DATE
unset END_TIME

echo ""

exit 0

