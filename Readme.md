Raspberry Pi 4 UEFI Firmware Images
===================================

[![Build status](https://img.shields.io/github/actions/workflow/status/pftf/RPi4/linux_edk2.yml?style=flat-square)](https://github.com/pftf/RPi4/actions)
[![Github stats](https://img.shields.io/github/downloads/pftf/RPi4/total.svg?style=flat-square)](https://github.com/pftf/RPi4/releases)
[![Release](https://img.shields.io/github/release-pre/pftf/RPi4?style=flat-square)](https://github.com/pftf/RPi4/releases)

# Summary

This repository contains installable builds of the official
[EDK2 Raspberry Pi 4 UEFI firmware](https://github.com/tianocore/edk2-platforms/tree/master/Platform/RaspberryPi/RPi4).

# Initial Notice

__PLEASE READ THE FOLLOWING:__  
🔻🔻🔻🔻🔻🔻🔻🔻🔻

* Ethernet networking support in Linux requires a recent enough kernel (version 5.7 or
  later)

* SD or wireless support in Linux also requires a recent enough kernel (version 5.12 or
  later).  
  Still, your mileage may vary as to whether these peripherals will actually be usable.

* Many drivers (GPIO, VPU, etc) are still likely to be missing from your OS, and will
  have to be provided by a third party. Please do not ask for them here, as they fall
  outside of the scope of this project.

* A 3 GB RAM limit is enforced __by default__, even if you are using a Raspberry Pi 4
  model that has 4 GB or 8 GB of RAM, on account that the OS **must** patch DMA access,
  to work around a hardware bug that is present in the Broadcom SoC.  
  For Linux this usually translates to using a recent kernel (version 5.8 or later) and
  for Windows this requires the installation of a filter driver.  
  If you are running an OS that has been adequately patched,  you can disable the 3 GB
  limit by going to `Device Manager` → `Raspberry Pi Configuration` → `Advanced Settings`
  in the UEFI settings.

* This firmware is built from the
  [official EDK2 repository](https://github.com/tianocore/edk2-platforms/tree/master/Platform/RaspberryPi/RPi4),
  with the following extra patch applied:
  * `0001-MdeModulePkg-UefiBootManagerLib-Signal-ReadyToBoot-o.patch`, so that the
    Graphical console is set as default.

🔺🔺🔺🔺🔺🔺🔺🔺🔺

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
[GitHub CI artifacts](https://github.com/pftf/RPi4/actions).

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
[BSD-2-Clause-Patent](https://github.com/tianocore/edk2/blob/master/License.txt).

The other files from the zip archives are licensed under the terms described in the
[Raspberry Pi boot files README](https://github.com/raspberrypi/firmware/blob/master/README.md).

The binary blobs in the `firmware/` directory are licensed under the Cypress wireless driver
license that is found there.
