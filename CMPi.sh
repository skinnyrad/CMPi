#!/bin/bash

#
# Adapted from the Ubertooth Install script by Raul Siles, DinoSec SL (www.dinosec.com)
#
# Modified by Jason Baird
#

# Versions
UBER_VERSION=2020-12-R1

LIBBTBB_URL=https://github.com/greatscottgadgets/libbtbb/archive/$UBER_VERSION.tar.gz
LIBBTBB_FILENAME=libbtbb-$UBER_VERSION.tar.gz
LIBBTBB_DIR=libbtbb-$UBER_VERSION

UBERTOOTH_URL=https://github.com/greatscottgadgets/ubertooth/releases/download/$UBER_VERSION/ubertooth-$UBER_VERSION.tar.xz
UBERTOOTH_FILENAME=ubertooth-$UBER_VERSION.tar.xz
UBERTOOTH_DIR_HOST=ubertooth-$UBER_VERSION/host
UBERTOOTH_DIR=ubertooth-$UBER_VERSION

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
sudo apt-get update
sudo apt-get -y install cmake build-essential libusb-1.0-0-dev make gcc g++ libbluetooth-dev \
pkg-config libpcap-dev bluez-test-scripts libsqlite3-dev python3-bluez python3-dbus \
python3-numpy python3-qtpy python3-distutils python3-setuptools \
sqlite3 bluez-tools ruby-dev bluez bundler gedit wireshark

echo
echo "********** Building the Bluetooth baseband library (libbtbb) ********** "
echo
cd ~
wget $LIBBTBB_URL -O $LIBBTBB_FILENAME
tar -xf $LIBBTBB_FILENAME
cd $LIBBTBB_DIR
mkdir build
cd build
cmake ..
make
sudo make install
sudo ldconfig

echo
echo "********** Installing Ubertooth tools ********** "
echo
cd ~
wget $UBERTOOTH_URL
tar -xf $UBERTOOTH_FILENAME
cd $UBERTOOTH_DIR_HOST
mkdir build
cd build
cmake ..
make
sudo make install
sudo ldconfig

echo
echo "********** Install Kismet ********** "
echo
wget -O - https://www.kismetwireless.net/repos/kismet-release.gpg.key --quiet | gpg --dearmor | sudo tee /usr/share/keyrings/kismet-archive-keyring.gpg >/dev/null
echo 'deb [signed-by=/usr/share/keyrings/kismet-archive-keyring.gpg] https://www.kismetwireless.net/repos/apt/git/bookworm bookworm main' | sudo tee /etc/apt/sources.list.d/kismet.list >/dev/null
sudo apt update
sudo apt install kismet
sudo usermod -aG kismet $USER

echo
echo "********** Install Blue Hydra ********** "
echo
cd ~
mkdir ~/blue_hydra
git clone https://github.com/ZeroChaos-/blue_hydra.git ~/blue_hydra
cd ~/blue_hydra/
bundle install

echo
echo "****Install Blue Sonar****"
echo
cd ~
git clone https://github.com/ZeroChaos-/blue_sonar

echo
echo "****Install Red Fang****"
echo
cd ~
git clone https://gitlab.com/kalilinux/packages/redfang
cd ~/redfang
make

echo "**** Install UAPfuzz ****"
cd ~
git clone https://github.com/skinnyrad/uapfuzz
echo

echo "**** Install HackRF ****"
cd ~
sudo apt install hackrf
echo

echo "**** Install SDR++ ****"
cd ~/CMPi
sudo dpkg -i sdrpp_raspbian_arm64.deb
echo

echo
echo "****Create Permanent Aliases****"
echo
cd ~
echo "alias blue_sonar='sudo ~/blue_sonar/blue_sonar'" >> .bash_aliases
echo "alias blue_hydra='sudo ~/blue_hydra/bin/blue_hydra'" >> .bash_aliases
echo "alias fang='sudo ~/redfang/fang'" >> .bash_aliases
echo "alias uapfuzz='~/uapfuzz/uapfuzz.sh'" >> .bash_aliases

echo
echo "********** Install aircrack-ng ********** "
echo
sudo apt-get -y install aircrack-ng

echo
echo "********** Fix Small LCD Screen/Bluetooth Serial Problem ********** "
echo
FILE22=~/LCD-show
if [ -d "$FILE22" ]; then
    echo "$FILE22 does exist."
    sudo cp -rf ~/CMPi/cmdline.txt /boot/cmdline.txt
else
    echo "There is no small LCD Screen directory. Assuming no screen or larger screen is being used. Fix Terminated"
fi

echo
echo "**** Lighten up that LXTerminal Foreground ****"
echo
FILE23=~/.config/lxterminal/lxterminal.conf
if [ -f "$FILE23" ]; then
    echo "$FILE23 does exist."
    sed -i 's/fgcolor=rgb(170,170,170)/fgcolor=rgb(255,255,255)/g' ~/.config/lxterminal/lxterminal.conf
    echo "Enjoy a brighter text color in the Terminal!"
else
    echo "LX Terminal does not exist or the fgcolor has been changed to something else."
fi

echo
echo "**** Skinny R&D Backgound ****"
echo
wget https://skinnyrd.com/wp-content/uploads/2023/02/Screensaver.png -O ~/Pictures/Desktop01.png
pcmanfm --set-wallpaper ~/Pictures/Desktop01.png

echo
echo "**** A Reboot Will Occur in 10 Seconds ****"
echo
sleep 5
echo "5 seconds remaining..."
sleep 5
reboot
