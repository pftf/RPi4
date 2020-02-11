#

# Download required boot files

LINK="https://github.com/raspberrypi/firmware/raw/master/boot"
wget $LINK/fixup4.dat
wget $LINK/start4.elf
wget $LINK/bcm2711-rpi-4-b.dtb
wget $LINK/overlays/miniuart-bt.dtbo
mkdir overlays
mv miniuart-bt.dtbo overlays
mkdir Firmware

# Compile base tools and prepare environment

make -C edk2/BaseTools || exit 1
export GCC5_AARCH64_PREFIX=aarch64-linux-gnu-
export WORKSPACE=$PWD
export PACKAGES_PATH=$WORKSPACE/edk2:$WORKSPACE/edk2-platforms:$WORKSPACE/edk2-non-osi
source edk2/edksetup.sh || exit 1

# Build the EFI files

build -a AARCH64 -t GCC5 -p edk2-platforms/Platform/RaspberryPi/RPi4/RPi4.dsc -b DEBUG --pcd gEfiMdeModulePkgTokenSpaceGuid.PcdFirmwareVendor=L"https://github.com/pftf/RPi4" --pcd gEfiMdeModulePkgTokenSpaceGuid.PcdFirmwareVersionString=L"UEFI Firmware $APPVEYOR_REPO_TAG_NAME (DEBUG)" || exit 1
cp Build/RPi4/DEBUG_GCC5/FV/RPI_EFI.fd Firmware/RPI_M4D.fd
build -a AARCH64 -t GCC5 -p edk2-platforms/Platform/RaspberryPi/RPi4/RPi4.dsc -b DEBUG -D ACPI_BASIC_MODE_ENABLE=1 --pcd gEfiMdeModulePkgTokenSpaceGuid.PcdFirmwareVendor=L"https://github.com/pftf/RPi4" --pcd gEfiMdeModulePkgTokenSpaceGuid.PcdFirmwareVersionString=L"UEFI Firmware $APPVEYOR_REPO_TAG_NAME (DEBUG)" || exit 1
cp Build/RPi4/DEBUG_GCC5/FV/RPI_EFI.fd Firmware/RPI_M3D.fd
rm -rf Build
build -a AARCH64 -t GCC5 -p edk2-platforms/Platform/RaspberryPi/RPi4/RPi4.dsc -b DEBUG -D PL011_ENABLE=1 --pcd gEfiMdeModulePkgTokenSpaceGuid.PcdFirmwareVendor=L"https://github.com/pftf/RPi4" --pcd gEfiMdeModulePkgTokenSpaceGuid.PcdFirmwareVersionString=L"UEFI Firmware $APPVEYOR_REPO_TAG_NAME (DEBUG)" || exit 1
cp Build/RPi4/DEBUG_GCC5/FV/RPI_EFI.fd Firmware/RPI_P4D.fd
build -a AARCH64 -t GCC5 -p edk2-platforms/Platform/RaspberryPi/RPi4/RPi4.dsc -b DEBUG -D PL011_ENABLE=1 -D ACPI_BASIC_MODE_ENABLE=1 --pcd gEfiMdeModulePkgTokenSpaceGuid.PcdFirmwareVendor=L"https://github.com/pftf/RPi4" --pcd gEfiMdeModulePkgTokenSpaceGuid.PcdFirmwareVersionString=L"UEFI Firmware $APPVEYOR_REPO_TAG_NAME (DEBUG)" || exit 1
cp Build/RPi4/DEBUG_GCC5/FV/RPI_EFI.fd Firmware/RPI_P3D.fd
build -a AARCH64 -t GCC5 -p edk2-platforms/Platform/RaspberryPi/RPi4/RPi4.dsc -b RELEASE -D SECURE_BOOT_ENABLE=TRUE -D INCLUDE_TFTP_COMMAND=TRUE -D PL011_ENABLE=1 -D ACPI_BASIC_MODE_ENABLE=1 --pcd gEfiMdeModulePkgTokenSpaceGuid.PcdFirmwareVendor=L"https://github.com/pftf/RPi4" --pcd gEfiMdeModulePkgTokenSpaceGuid.PcdFirmwareVersionString=L"UEFI Firmware $APPVEYOR_REPO_TAG_NAME" || exit 1
