#
make -C edk2/BaseTools || exit 1
export GCC5_AARCH64_PREFIX=aarch64-linux-gnu-
export WORKSPACE=$PWD
export PACKAGES_PATH=$WORKSPACE/edk2:$WORKSPACE/edk2-platforms:$WORKSPACE/edk2-non-osi
source edk2/edksetup.sh || exit 1
build -a AARCH64 -t GCC5 -p edk2-platforms/Platform/RaspberryPi/RPi4/RPi4.dsc -b DEBUG --pcd gEfiMdeModulePkgTokenSpaceGuid.PcdFirmwareVendor=L"https://github.com/pftf/RPi4" --pcd gEfiMdeModulePkgTokenSpaceGuid.PcdFirmwareVersionString=L"UEFI Firmware $APPVEYOR_REPO_TAG_NAME (DEBUG)" || exit 1
build -a AARCH64 -t GCC5 -p edk2-platforms/Platform/RaspberryPi/RPi4/RPi4.dsc -b RELEASE --pcd gEfiMdeModulePkgTokenSpaceGuid.PcdFirmwareVendor=L"https://github.com/pftf/RPi4" --pcd gEfiMdeModulePkgTokenSpaceGuid.PcdFirmwareVersionString=L"UEFI Firmware $APPVEYOR_REPO_TAG_NAME" -D SECURE_BOOT_ENABLE=TRUE -D INCLUDE_TFTP_COMMAND=TRUE || exit 1
