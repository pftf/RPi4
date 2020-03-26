Raspberry Pi 4 UEFI Firmware Images
===================================

[![Build status](https://img.shields.io/appveyor/ci/pbatard/RPi4.svg?style=flat-square)](https://ci.appveyor.com/project/pbatard/RPi4)
[![Github stats](https://img.shields.io/github/downloads/pftf/RPi4/total.svg?style=flat-square)](https://github.com/pftf/RPi4/releases)

# Summary

This repository contains __EXPERIMENTAL__ installable builds of the official
[EDK2 Raspberry Pi 4 UEFI firmware](https://github.com/tianocore/edk2-platforms/tree/master/Platform/RaspberryPi/RPi4).

# Initial Notice

__PLEASE READ THE FOLLOWING:__  
&#x1F53B;&#x1F53B;&#x1F53B;&#x1F53B;&#x1F53B;&#x1F53B;&#x1F53B;&#x1F53B;&#x1F53B;

* Do __NOT__ expect this firmware to be fully functional when it comes to supporting
  your ARM64 OS of choice (or even to support your OS at all if you plan to use
  Windows),  as it is still very much in development stage.

* You will __NOT__ get SD or network support in Linux because current Linux kernels
  are missing updated network and SD card drivers for ACPI.

* You will __NOT__ be able to use any of the USB-A ports if you try to run Windows.
  This means that any attempt to boot Windows from a USB drive plugged at the back
  of your device will crash.

* Please understand that you are using an __EXPERIMENTAL__ firmware, which means that
  not everything is expected to be working and that you may have to wait for a more
  stable release (which may be months away) if you want something that "simply works".

* This firmware was built from the
  [official EDK2 repository](https://github.com/tianocore/edk2-platforms/tree/master/Platform/RaspberryPi/RPi4),
  with no alterations.  
  If you need more information, please refer to that repository.

&#x1F53A;&#x1F53A;&#x1F53A;&#x1F53A;&#x1F53A;&#x1F53A;&#x1F53A;&#x1F53A;&#x1F53A;

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

# Additional Notes

The firmware provided in the zip archive is the `RELEASE` version but you can also find
a `DEBUG` build of the firmware in the
[AppVeyor artifacts](https://ci.appveyor.com/project/pbatard/RPi4/build/artifacts).

The provided firmwares should be able to auto-detect the UART being used (PL011 or mini
UART) according to whether `config.txt` contains the relevant overlay or not. The default
baudrate for serial I/O is `115200` and the console device to use under Linux is either
`/dev/ttyAMA0` when using PL011 or `/dev/ttyS0` when using miniUART.

At the moment, the published firmwares default to enforcing ACPI as well as a 3 GB RAM
limit, which is done to ensure Linux boot. These settings can be changed by going to
`Device Manager` &rarr; `Raspberry Pi Configuration` &rarr; `Advanced Configuration`.

Please visit https://rpi4-uefi.dev/ for more information.

# License

The firmware (`RPI_EFI.fd`) is licensed under the current EDK2 license, which is
[BSD-3-Clause](https://github.com/ARM-software/arm-trusted-firmware/blob/master/license.rst).

The other files from the zip archives are licensed under the terms described in the
[Raspberry Pi boot files README](https://github.com/raspberrypi/firmware/blob/master/README.md).
