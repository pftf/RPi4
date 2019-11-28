Raspberry Pi 4 UEFI Firmware Images
===================================

[![Build status](https://img.shields.io/appveyor/ci/pbatard/RPi4.svg?style=flat-square)](https://ci.appveyor.com/project/pbatard/RPi4)
[![Github stats](https://img.shields.io/github/downloads/pftf/RPi4/total.svg?style=flat-square)](https://github.com/pftf/RPi4/releases)

# Summary

This repository contains __EARLY EXPERIMENTAL__ builds of the EDK2 Raspberry Pi 4 UEFI firmware.

Please do not expect to boot much of anything at this stage, as this firmware, which has yet to
be integrated to the EDK2, is very much in early development stage.

# Installation

* Download the latest archive from the [Releases](https://github.com/pbatard/RPI4/releases) repository.

* Create an SD card in `MBR` mode with a single partition of type `0x0c` (`FAT32 LBA`) or `0x0e`
  (`FAT16 LBA`). Then format this partition to `FAT`.

  __Note:__ Do not try to use `GPT` for the partition scheme or `0xef` (`EFI System
  Partition`)  for the type, as these are unsupported by the CPU-embedded bootloader.

* Extract all the files from the archive onto the partition you created above.  
  Note that outside of this `Readme.md`, which you can safely remove, you should not
  change the name of the extracted files and directories.

# Usage

Insert the SD card/plug the USB drive and power up your Raspberry Pi. You should see a
multicoloured screen (which indicates that the CPU-embedded bootloader is reading the
data from the SD/USB partition) and then the Raspberry Pi black and white logo once the
UEFI firmware is ready.

At this stage, you can press <kbd>Esc</kbd> to enter the firmware setup, <kbd>F1</kbd>
to launch the UEFI Shell, or, provided you also have copied an UEFI bootloader in
`efi/boot/bootaa64.efi`, you can let the UEFI system run that (which it should do by
default if no action is taken).

# Notes

The firmware provided in the zip archive is the `RELEASE` version but you can also find
`DEBUG` builds of the firmware in the 
[AppVeyor artifacts](https://ci.appveyor.com/project/pbatard/RPi4/build/artifacts).

The default baudrate for serial I/O is 115200 bauds.

Note that you __MUST__ have both a `bcm2711-rpi-4-b.dtb` at the root of your SD card
and `core_freq=250` in your `config.txt` for the baudrate to be set properly.

# License

The firmware (`RPI_EFI.fd`) is licensed under the current EDK2 license, which is
[BSD-3-Clause](https://github.com/ARM-software/arm-trusted-firmware/blob/master/license.rst).

The other files from the zip archives are licensed under the terms described in the
[Raspberry Pi boot files README](https://github.com/raspberrypi/firmware/blob/master/README.md).
