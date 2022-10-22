# Countermeasures Pi

CMPi is an install script that allows the user to install a variety of wireless tools onto Raspbian. This current version of CMPi has been tested with a clean, Bullseye version of Raspbian.

## Software Installed
- Ubertooth dependencies and libraries (2020-12-R1) (https://github.com/greatscottgadgets/ubertooth)
- Ubertooth tools (2020-12-R1)
- libbtbb (2020-12-R1)
- Kismet 2020-12-R3 (https://www.kismetwireless.net/docs/readme/packages/)
- Blue Hydra (https://github.com/pwnieexpress/blue_hydra)
- Aircrack-ng
- Blue Sonar

## Required Hardware
- Raspberry Pi 3B+ or 4
- Ubertooth 1
- Monitor mode capable USB WiFi adapter
- USB Bluetooth adapter or On-board Bluetooth interface

## Required Software
- Raspbian Bullseye

## Optional Hardware
- Miuzei Raspberry Pi 4 Touchscreen with Case & Fan (https://www.amazon.com/gp/product/B07XBVF1C9/ref=ppx_od_dt_b_asin_title_s01?ie=UTF8&psc=1)
- SunFounder TS-7 Pro 7 inch Raspberry Pi Touch Screen (https://www.sunfounder.com/collections/touchscreens/products/ts-7-pro-7-inch-touch-screen)

## Installation Procedure
To install type the following pressing Enter at the end of each line.

```
sudo apt-get update
git clone https://github.com/skinnyrad/CMPi.git
cd CMPi
sudo ./CMPi.sh
```
