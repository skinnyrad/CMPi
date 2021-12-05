# Countermeasures Pi

CMPi is an install script that allows the user to install Ubertooth, Ubertooth tools, Kimset, Blue Hydra, and all their dependencies onto Raspbian. This current version of CMPi has been tested with a clean, Buster version of Raspbian.

## Software Installed
- Ubertooth dependencies and libraries (2020-12-R1) (https://github.com/greatscottgadgets/ubertooth)
- Ubertooth tools (2020-12-R1)
- libbtbb (2020-12-R1)
- Kismet 2020-12-R3 (https://www.kismetwireless.net/docs/readme/packages/)
- Blue Hydra (https://github.com/pwnieexpress/blue_hydra)
- Aircrack-ng

## Required Hardware
- Raspberry Pi 3B+ or 4
- Ubertooth 1
- Compliant USB WiFi adapter for Kismet
- USB Bluetooth adapter or On-board Bluetooth interface

## Required Software
- Raspbian Bullseye (https://downloads.raspberrypi.org/raspios_armhf/images/raspios_armhf-2021-11-08/2021-10-30-raspios-bullseye-armhf.zip)

## Optional Hardware
- Miuzei Raspberry Pi 4 Touchscreen with Case & Fan (https://www.amazon.com/gp/product/B07XBVF1C9/ref=ppx_od_dt_b_asin_title_s01?ie=UTF8&psc=1)

To install type the following pressing Enter at the end of each line.

```
sudo apt-get update
git clone https://github.com/skinnyrad/CMPi.git
cd CMPi
sudo ./CMPi.sh
```
