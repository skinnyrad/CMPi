# Countermeasures Pi

CMPi is an install script that allows the user to install Ubertooth, Ubertooth tools, Kimset, Blue Hydra, and all their dependencies onto Raspbian. This current version of CMPi has been tested with a clean, Buster version of Raspbian.

## Software Installed
- Ubertooth dependencies and libraries (2020-12-R1) (https://github.com/greatscottgadgets/ubertooth)
- Ubertooth tools (2020-12-R1)
- libbtbb (2020-12-R1)
- Kismet 2020-12-R3 (https://www.kismetwireless.net/docs/readme/packages/)
- Blue Hydra (https://github.com/pwnieexpress/blue_hydra)

## Required Hardware
- Raspberry Pi 3B+ or 4
- Ubertooth 1
- Compliant USB WiFi adapter for Kismet
- USB Bluetooth adapter or On-board Bluetooth interface

To install type the following pressing Enter at the end of each line.

```
sudo apt-get update
git clone https://github.com/skinnyrad/CMPi.git
cd CMPi
sudo ./CMPi.sh
```
