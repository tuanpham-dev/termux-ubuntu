#!/bin/bash
echo "Enabling PPA support..."
[ ! -f .parrot ] && sudo apt-get update; sudo apt-get install software-properties-common --no-install-recommends -y
echo " Adding chromium-team stable ppa"
sudo echo "deb http://ppa.launchpad.net/ultrahacx/chromium-universal/ubuntu bionic main 
deb-src http://ppa.launchpad.net/ultrahacx/chromium-universal/ubuntu bionic main " >> /etc/apt/sources.list
echo "Fetching and importing chromium-team GPG keys..."
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 8FEA526CE21182D1
echo "Installing chromium-browser"
sudo apt-get update; sudo apt-get install chromium-browser --no-install-recommends -y
echo "Patching application shortcuts..."
sed -i 's/chromium-browser %U/chromium-browser --no-sandbox %U/g' /usr/share/applications/chromium-browser.desktop
