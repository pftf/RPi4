Raspberry Pi 4 UEFI Firmware Images
===================================

[![Build status](https://img.shields.io/appveyor/ci/pbatard/RPi4.svg?style=flat-square)](https://ci.appveyor.com/project/pbatard/RPi4)
[![Github stats](https://img.shields.io/github/downloads/pftf/RPi4/total.svg?style=flat-square)](https://github.com/pftf/RPi4/releases)
[![Release](https://img.shields.io/github/release-pre/pftf/RPi4?style=flat-square)](https://github.com/pftf/RPi4/releases)

# Summary

This repository contains __EXPERIMENTAL__ installable builds of the official
[EDK2 Raspberry Pi 4 UEFI firmware](https://github.com/tianocore/edk2-platforms/tree/master/Platform/RaspberryPi/RPi4).

# Initial Notice

__PLEASE READ THE FOLLOWING:__  
&#x1F53B;&#x1F53B;&#x1F53B;&#x1F53B;&#x1F53B;&#x1F53B;&#x1F53B;&#x1F53B;&#x1F53B;

* Do __NOT__ expect this firmware to be fully functional when it comes to supporting
  your ARM64 OS of choice or providing all the features you would expect from a
  regular UEFI platform. This is __EXPERIMENTAL__ software.

* You will __NOT__ get SD or wireless support in Linux because current Linux kernels
  are missing updated SD/Wifi drivers with the required ACPI bindings.

* You may __NOT__ get Ethernet networking support in Linux, unless you use a __recent__
  Linux kernel (version 5.7 or later) or one into which the 5.7 fixes have been
  backported.

* You will __NOT__ get networking in Windows unless you use an external adapter, for
  which an ARM64 driver already exists. Especially, native Ethernet or Wifi support
  on Windows will only happen if Broadcom, or a third party, produces a new driver...

* You will __NOT__ be able to use the USB-A ports in Windows, unless you manually
  patch the `usbxhci.sys` driver. Provided you are installing a recent version of
  Windows 10 for ARM64 (20H1 or later) this may be accomplished using the command
  line and Windows utility found [here](https://github.com/pbatard/winpatch).

* Most OSes will be not be able to use more than 3 GB of RAM, even if you have a 4 GB
  or 8 GB model. This is the result of a hardware bug in the Broadcom CPU that powers
  the Rapsberry Pi 4. In order to be able to access more than 3 GB of RAM, OSes such
  as Linux or Windows require a workaround, like the one proposed in issue #20.

* Be very mindful that not everything you want can be solved through a UEFI firmware
  update. Especially, some elements to make an OS fully functional do require an OS
  update, an OS workaround (such as the one mentioned above) or new OS drivers, which
  are beyond the scope of this project.

* This firmware was built from the
  [official EDK2 repository](https://github.com/tianocore/edk2-platforms/tree/master/Platform/RaspberryPi/RPi4),
  with the following extra patches applied:
  * `0001-MdeModulePkg-UefiBootManagerLib-Signal-ReadyToBoot-o.patch`, so that the
    Graphical console is set as default.
  * `0002-Platform-RaspberryPi-Add-MCFG-table.patch` to silence a benign
    `ACPI: Failed to parse MCFG (-19)` message thrown by Debian during boot.

&#x1F53A;&#x1F53A;&#x1F53A;&#x1F53A;&#x1F53A;&#x1F53A;&#x1F53A;&#x1F53A;&#x1F53A;

# Installation

* Download the latest archive from the [Releases](https://github.com/pftf/RPi4/releases)
  repository.

* Create an SD card or a USB drive, with at least one partition (it can be a regular
  partition or an [ESP](https://en.wikipedia.org/wiki/EFI_system_partition)) and format
  it to FAT16 or FAT32.

  __Note:__ Booting from USB or from ESP requires a recent-enough version of the Pi
  EEPROM (as well as a recent version of the UEFI firmware). If you are using the latest
  UEFI firmware and find that booting from USB or from ESP doesn't work, please visit
  https://github.com/raspberrypi/rpi-eeprom/releases to update your EEPROM.

* Extract all the files from the archive onto the partition you created above.  
  Note that outside of this `Readme.md`, which you can safely remove, you should not
  change the names of the extracted files and directories.

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
