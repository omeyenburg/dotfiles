# Keyboards
This folder contains my configuration of the [cheapino](https://github.com/tompi/cheapino) keyboard.
QMK is required for building.

## Setup
Install [QMK](https://msys.qmk.fm/), then run `qmk setup`.
Run `make qmk` in this repository to link the custom configuration.

## Flashing

1. Connect the keyboard in dfu mode.
2. Run `qmk flash -kb [keyboard] -km [keymap]` or `make [keyboard]:[keymap]:flash`

- The gcc-arm-embedded package might be required for flashing.
- If it hangs up flashing, you have to mount the keyboard manually.
- Possibly flashing must be done as root user.
