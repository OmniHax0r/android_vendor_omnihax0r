########## standard build envs ##########
export USE_CCACHE=1
export CCACHE_EXEC=$(which ccache)
########### extendrom section ##########
if [ ! -z ${BOARD_MAGISK_INIT} ] && [ ${BOARD_MAGISK_INIT} == true ]; then
	export ENABLE_EXTENDROM=true
	export EXTENDROM_PREROOT_BOOT=true
	export EXTENDROM_PACKAGES="Magisk | SignMagisk"
	$PWD/vendor/extendrom/get_prebuilts.sh
fi
