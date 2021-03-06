#!/bin/bash

#
# Adapted from the Ubertooth Install script by Raul Siles, DinoSec SL (www.dinosec.com)
#
# Modified by Jason Baird
#
# Ubertooth and libbtbb versions: 2020-12-R1
# Kismet version: 2020-12-R3

# Versions
VERSION=2020-12-R1
UBER_VERSION=2020-12-R1

LIBBTBB_URL=https://github.com/greatscottgadgets/libbtbb/archive/$UBER_VERSION.tar.gz
LIBBTBB_FILENAME=libbtbb-$UBER_VERSION.tar.gz
LIBBTBB_DIR=libbtbb-$UBER_VERSION
LIBBTBB_BACK=../..

UBERTOOTH_URL=https://github.com/greatscottgadgets/ubertooth/releases/download/$UBER_VERSION/ubertooth-$UBER_VERSION.tar.xz
UBERTOOTH_FILENAME=ubertooth-$UBER_VERSION.tar.xz
UBERTOOTH_DIR_HOST=ubertooth-$UBER_VERSION/host
UBERTOOTH_DIR=ubertooth-$UBER_VERSION
UBERTOOTH_BACK=../../..

KISMET_BACK=..

echo
echo "  _____ _____ _____ ___  ___ ______ _  "
echo " |_   _/  ___/  __ \\|  \/  | | ___ (_) "
echo "   | | \\ \`--.| /  \\/| .  . | | |_/ /   "
echo "   | |  \`--. \\ |    | |\\/| | |  __/| | "
echo "   | | /\\__/ / \\__/\\| |  | | | |   | | "
echo "   \\_/ \\____/ \\____/\\_|  |_/ \\_|   |_| "
echo
echo

echo "  (*** Internet access is required ***)"
echo "  (*** This script will run for a few minutes. ***)"
echo
echo "  Press any key to continue (or Ctrl+C):"
read key

echo "********** Installing dependencies ********** "
echo
cd ~
sudo apt-get install cmake libusb-1.0-0-dev make gcc g++ libbluetooth-dev \
pkg-config libpcap-dev python-pyside python-bluez python-dbus \
python3-numpy python3-qtpy python3-distutils python3-setuptools \
sqlite3 bluez-tools ruby-dev bluez bluez-test-scripts libsqlite3-dev

echo
echo "********** Install Kismet ********** "
echo
#sudo apt-get -y install libpcap0.8-dev libcap-dev pkg-config build-essential libnl-3-dev libnl-genl-3-dev libncurses5-dev libpcre3-dev libpcap-dev libcap-dev
wget -O - https://www.kismetwireless.net/repos/kismet-release.gpg.key | sudo apt-key add -
echo 'deb https://www.kismetwireless.net/repos/apt/release/buster buster main' | sudo tee /etc/apt/sources.list.d/kismet.list
sudo apt update
sudo apt install kismet
sudo usermod -aG kismet pi

echo
echo "********** Building the Bluetooth baseband library (libbtbb) ********** "
echo
wget $LIBBTBB_URL -O $LIBBTBB_FILENAME
tar -xf $LIBBTBB_FILENAME
cd $LIBBTBB_DIR
mkdir build
cd build
cmake ..
make
sudo make install
sudo ldconfig
cd $LIBBTBB_BACK

echo
echo "********** Installing Ubertooth tools ********** "
echo
wget $UBERTOOTH_URL
tar -xf $UBERTOOTH_FILENAME
cd $UBERTOOTH_DIR_HOST
mkdir build
cd build
cmake ..
make
sudo make install
sudo ldconfig
cd $UBERTOOTH_BACK

echo
echo "********** Install Blue Hydra ********** "
echo
sudo gem install bundler
mkdir /home/pi/blue_hydra
git clone https://github.com/pwnieexpress/blue_hydra.git /home/pi/blue_hydra
cd /home/pi/blue_hydra/
bundle install

echo
echo "********** Install aircrack-ng ********** "
echo
sudo apt-get install aircrack-ng

echo
echo "[*] End of the install script. Congratulations! ;)"
echo
