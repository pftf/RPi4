Raspberry Pi 4 UEFI Firmware Images
===================================

[![Build status](https://img.shields.io/appveyor/ci/pbatard/RPi4.svg?style=flat-square)](https://ci.appveyor.com/project/pbatard/RPi4)
[![Github stats](https://img.shields.io/github/downloads/pftf/RPi4/total.svg?style=flat-square)](https://github.com/pftf/RPi4/releases)

# Summary

This repository contains __EXPERIMENTAL__ installable builds of the official
[EDK2 Raspberry Pi 4 UEFI firmware](https://github.com/tianocore/edk2-platforms/tree/master/Platform/RaspberryPi/RPi4).

Please do not expect the firmware to be fully functional when it comes to supporting your
ARM64 OS of choice (or even to support your OS at all if you plan to use Windows), as it
is still very much in development stage.

You may however find that you can use the firmware to boot and install Linux from USB
(tested with Debian 10.2 for ARM64, with the caveat that you NIC and SD card will be
unavailable due to the current Debian kernel missing up to date drivers).

This firmware is built from the official EDK2 repositories, with no alterations.

# Installation

* Download the latest archive from the [Releases](https://github.com/pftf/RPi4/releases)
  repository.

* Create an SD card in `MBR` mode with a single partition of type `0x0c` (`FAT32 LBA`)
  or `0x0e` (`FAT16 LBA`). Then format this partition to `FAT`.

  __Note:__ Do not try to use `GPT` for the partition scheme or `0xef` (`EFI System
  Partition`)  for the type, as these are unsupported by the Raspberry Pi bootloader(s).

* Extract all the files from the archive onto the partition you created above.  
  Note that outside of this `Readme.md`, which you can safely remove, you should not
  change the name of the extracted files and directories.

# Usage

Insert the SD card/plug the USB drive and power up your Raspberry Pi. You should see a
multicoloured screen (which indicates that the CPU-embedded bootloader is reading the
data from the SD/USB partition) and then the Raspberry Pi black and white logo once the
UEFI firmware is ready.

At this stage, you can press <kbd>Esc</kbd> to enter the firmware setup, <kbd>F1</kbd>
to launch the UEFI Shell, or, provided you also have an UEFI bootloader on the SD 
card or on a USB drive in `efi/boot/bootaa64.efi`, you can let the UEFI system run that
(which will be the default if no action is taken).

# Notes

The firmware provided in the zip archive is the `RELEASE` version but you can also find
some `DEBUG` builds of the firmware in the 
[AppVeyor artifacts](https://ci.appveyor.com/project/pbatard/RPi4/build/artifacts).

The RELEASE firmware from the archive uses PL011 for serial (`-D PL011_ENABLE=1`), which
means that it uses mini UART for Bluetooth (hence the `minuartbt` overlay in `config.txt`).  
It also enforces ACPI and comes with a 3 GB RAM limitation (`-D ACPI_BASIC_MODE_ENABLE=1`)
to ensure Linux boot.

The default baudrate for serial I/O is 115200 and the console device to use under Linux
is `/dev/ttyAMA0`.

# License

The firmware (`RPI_EFI.fd`) is licensed under the current EDK2 license, which is
[BSD-3-Clause](https://github.com/ARM-software/arm-trusted-firmware/blob/master/license.rst).

The other files from the zip archives are licensed under the terms described in the
[Raspberry Pi boot files README](https://github.com/raspberrypi/firmware/blob/master/README.md).
