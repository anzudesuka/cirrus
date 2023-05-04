#sync rom
repo init --depth=1 --no-repo-verify -u https://github.com/DerpFest-AOSP/manifest.git -b 13 -g default,-mips,-darwin,-notdefault
git clone https://github.com/mizuswork/local_manifests --depth 1 -b main .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom
source $CIRRUS_WORKING_DIR/config
timeStart

source build/envsetup.sh
export TZ=Asia/Jakarta
export KBUILD_BUILD_USER=Mizushudesuyo
export KBUILD_BUILD_HOST=weeb
export BUILD_USERNAME=Mizushudesuyo
export BUILD_HOSTNAME=weeb
lunch derp_lavender-user
mkfifo reading # Jangan di Hapus
tee "${BUILDLOG}" < reading & # Jangan di Hapus
build_message "Building Started" # Jangan di Hapus
progress & # Jangan di Hapus
timeout 95m mka derp -j8 > reading # Jangan di hapus text line (> reading)

retVal=$?
timeEnd
statusBuild
# end
