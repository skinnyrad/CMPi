#!/bin/bash

#
# Adapted from the Ubertooth Install script by Raul Siles, DinoSec SL (www.dinosec.com)
#
# Modified by Jason Baird
#

echo
echo "********** Checking Proper Use ********** "
echo
if [[ $EUID -eq 0 ]]; then
    echo "ERROR: This script must NOT be run as root or with sudo privileges." >&2
    exit 1
fi

SCRIPT_DIR="$(dirname "$(readlink -f "$0")")"

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
python3-numpy python3-qtpy python3-setuptools \
sqlite3 bluez-tools ruby-dev bluez bundler gedit wireshark

echo "not instaling python3-distutils as normal"

echo
echo "********** Installing Local libubertooth1 ********** "
echo
cd "$SCRIPT_DIR"
sudo apt -y install ./libubertooth1_debian_arm64.deb
echo

echo
echo "********** Installing Local ubertooth ********** "
echo
cd "$SCRIPT_DIR"
sudo apt -y install ./ubertooth_debian_arm64.deb
echo

echo
echo "********** Install Kismet ********** "
echo
wget -O - https://www.kismetwireless.net/repos/kismet-release.gpg.key --quiet | gpg --dearmor | sudo tee /usr/share/keyrings/kismet-archive-keyring.gpg >/dev/null
echo 'deb [signed-by=/usr/share/keyrings/kismet-archive-keyring.gpg] https://www.kismetwireless.net/repos/apt/release/trixie trixie main' | sudo tee /etc/apt/sources.list.d/kismet.list >/dev/null
sudo apt update
sudo apt -y install kismet
sudo usermod -aG kismet $USER

echo
echo "********** Install Blue Hydra ********** "
echo
cd ~
mkdir ~/blue_hydra
git clone https://github.com/ZeroChaos-/blue_hydra.git ~/blue_hydra
cd ~/blue_hydra/
sudo bundle install

echo "**** Patching BlueHydra Gem (if needed) ****"
cd ~
GEM_INFO=$(gem list -d data_objects 2>/dev/null)

if [[ -n "$GEM_INFO" ]]; then
    VERSION=$(echo "$GEM_INFO" | awk '/data_objects \([0-9.]+\)/ {gsub(/[()]/, "", $2); print $2}')
    INSTALL_DIR=$(echo "$GEM_INFO" | awk '/Installed at:/ {print $3}')
    # Only proceed if version is less than or equal to 0.10.17
    if [ "$(printf "%s\n0.10.17" "$VERSION" | sort -V | head -n1)" = "$VERSION" ]; then
        echo "Patching data_objects version $VERSION..."
        if cd "$INSTALL_DIR/gems/data_objects-$VERSION" 2>/dev/null; then
            if sudo wget https://pentoo.org/~zero/data_objects-fixnum2integer.patch; then
                if sudo patch -p1 < data_objects-fixnum2integer.patch; then
                    echo "Patch applied successfully"
                else
                    echo "Error: Patch failed"
                fi
            else
                echo "Error: Failed to download patch"
            fi
        else
            echo "Error: Could not change to gem directory"
        fi
    else
        echo "Info: data_objects version $VERSION does not require patching"
    fi
else
    echo "Warning: data_objects gem not installed"
fi
echo

echo
echo "****Install Blue Sonar****"
echo
cd ~
git clone https://github.com/ZeroChaos-/blue_sonar

echo
echo "****Install Red Fang****"
echo
cd "$SCRIPT_DIR"
sudo apt -y install ./redfang_debian_arm64.deb
echo

echo "**** Install UAPfuzz ****"
cd ~
git clone https://github.com/skinnyrad/uapfuzz
echo

echo "**** Install HackRF ****"
cd ~
sudo apt -y install hackrf
echo

echo "**** Install SDR++ ****"
cd "$SCRIPT_DIR"
wget https://github.com/AlexandreRouma/SDRPlusPlus/releases/download/nightly/sdrpp_debian_trixie_aarch64.deb
sudo apt -y install ./sdrpp_debian_trixie_aarch64.deb
echo

echo
echo "****Create Permanent Aliases****"
echo
cd ~
echo "alias blue_sonar='sudo ~/blue_sonar/blue_sonar'" >> .bash_aliases
echo "alias blue_hydra='sudo ~/blue_hydra/bin/blue_hydra'" >> .bash_aliases
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
