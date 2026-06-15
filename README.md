# Countermeasures Pi
CMPi is an install script that allows the user to install a variety of wireless tools onto Raspbian. This current version of CMPi has been tested with a clean, Trixie version of Raspbian.

## Software Installed
- Aircrack-ng
- Blue Hydra (https://github.com/ZeroChaos-/blue_hydra)
- Blue Sonar
- Gedit
- Kismet (https://www.kismetwireless.net)
- libbtbb (2020-12-R1)
- Red Fang
- UAP Fuzz
- Ubertooth tools (2020-12-R1)
- Wireshark
- SDR++
- Supertooth (https://github.com/daltoncox/supertooth)

## Required Hardware
- Raspberry Pi 3B+ or 4

## Suggested Operational Hardware
- Ubertooth 1
- HackRF
- Monitor mode capable USB WiFi adapter
- USB Bluetooth adapter or On-board Bluetooth interface

## Supported Display
- SunFounder TS-7 Pro 7 inch Raspberry Pi Touch Screen (https://www.sunfounder.com/collections/touchscreens/products/ts-7-pro-7-inch-touch-screen)

## Required Software
- Raspbian 64-bit (Trixie)

## Installation Procedure
To install type the following pressing Enter at the end of each line.

```
sudo apt-get update
git clone https://github.com/skinnyrad/CMPi.git
cd CMPi
./CMPi.sh
```
