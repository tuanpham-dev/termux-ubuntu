apt update -y && apt upgrade -y && apt install wget gnupg ffmpeg dialog xfce4-goodies libexo-1-0 -y
rm -rf /etc/resolv.conf
echo "nameserver 8.8.8.8" >> /etc/resolv.conf
chmod +x /usr/share/andronix/firstrun
mkdir -p ~/.vnc
# Fixes for udisks2
echo "" > /var/lib/dpkg/info/udisks2.postinst
dpkg --configure -a
apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 0CC3FD642696BFC8
groupadd --gid 3003 permagrp
groupadd --gid 9997 permagrp2
groupadd --gid 50110 permagrp3
groupadd --gid 99909997 permagrp4
groupadd --gid 20195 permagrp5
groupadd --gid 50195 permagrp6
chmod 4755 /usr/bin/sudo
rm -rf /etc/skel/.profile.1 /root/.profile.1
/usr/share/andronix/firstrun; exit
