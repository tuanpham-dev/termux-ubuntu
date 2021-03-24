#!/data/data/com.termux/files/usr/bin/bash
wget "https://andronixos.sfo2.cdn.digitaloceanspaces.com/OS-Files/setup-audio.sh" && chmod +x setup-audio.sh && ./setup-audio.sh

folder=ubuntu20-fs
dlink="https://raw.githubusercontent.com/AndronixApp/AndronixOrigin/master/APT"
if [ -d "$folder" ]; then
  first=1
  echo "skipping downloading"
fi
tarball="ubuntu20-rootfs.tar.gz"

if [ "$first" != 1 ];then
  if [ ! -f $tarball ]; then
    echo "Download Rootfs, this may take a while base on your internet speed."
    case `dpkg --print-architecture` in
    aarch64)
      archurl="arm64" ;;
    arm)
      archurl="armhf" ;;
    amd64)
      archurl="amd64" ;;
    x86_64)
      archurl="amd64" ;;  
    *)
      echo "unknown architecture"; exit 1 ;;
    esac
    wget "https://github.com/AndronixApp/AndronixOrigin/raw/master/Rootfs/Ubuntu20/focal-${archurl}.tar.gz" -O $tarball

  fi

  cur=`pwd`
  mkdir -p "$folder"
  cd "$folder"
  echo "Decompressing Rootfs, please be patient."
  proot --link2symlink tar -xf ${cur}/${tarball} --exclude=dev||:
  cd "$cur"
fi
mkdir -p ubuntu20-binds
bin=start-ubuntu20.sh
echo "writing launch script"
cat > $bin <<- EOM
#!/bin/bash
cd \$(dirname \$0)
pulseaudio -k >> /dev/null 2>&1
pulseaudio --start >> /dev/null 2>&1
unset LD_PRELOAD
command="proot"
command+=" --link2symlink"
command+=" -0"
command+=" -r $folder"
if [ -n "\$(ls -A ubuntu20-binds)" ]; then
  for f in ubuntu20-binds/* ;do
    . \$f
  done
fi
command+=" -b /dev"
command+=" -b /proc"
command+=" -b ubuntu20-fs/root:/dev/shm"
## uncomment the following line to have access to the home directory of termux
#command+=" -b /data/data/com.termux/files/home:/root"
## uncomment the following line to mount /sdcard directly to / 
#command+=" -b /sdcard"
command+=" -w /root"
command+=" /usr/bin/env -i"
command+=" HOME=/root"
command+=" PATH=/usr/local/sbin:/usr/local/bin:/bin:/usr/bin:/sbin:/usr/sbin:/usr/games:/usr/local/games"
command+=" TERM=\$TERM"
command+=" LANG=en_US.UTF-8"
command+=" LC_ALL=C"
command+=" LANGUAGE=en_US"
command+=" /bin/bash --login"
com="\$@"
if [ -z "\$1" ];then
  exec \$command
else
  \$command -c "\$com"
fi
EOM

mkdir -p ubuntu20-fs/usr/share/andronix
mkdir -p ubuntu20-fs/var/tmp
rm -rf ubuntu20-fs/usr/local/bin/*
echo "127.0.0.1 localhost" > $folder/etc/hosts
echo "Set disable_coredump false" > $folder/etc/sudo.conf
wget -q https://raw.githubusercontent.com/tuanpham-dev/termux-ubuntu/master/.bash_profile -O ubuntu20-fs/root/.bash_profile > /dev/null
wget -q https://raw.githubusercontent.com/tuanpham-dev/termux-ubuntu/master/vnc -P ubuntu20-fs/usr/local/bin > /dev/null
wget -q https://raw.githubusercontent.com/tuanpham-dev/termux-ubuntu/master/vncpasswd -P ubuntu20-fs/usr/local/bin > /dev/null
wget -q https://raw.githubusercontent.com/tuanpham-dev/termux-ubuntu/master/vncserver-stop -P ubuntu20-fs/usr/local/bin > /dev/null
wget -q https://raw.githubusercontent.com/tuanpham-dev/termux-ubuntu/master/vncserver-start -P ubuntu20-fs/usr/local/bin > /dev/null

wget -q https://raw.githubusercontent.com/tuanpham-dev/termux-ubuntu/master/firstrun -P ubuntu20-fs/usr/share/andronix > /dev/null

mkdir -p ubuntu20-fs/usr/share/andronix
case "$1" in
  "nde")
    ;;
  *)
    wget -q https://raw.githubusercontent.com/tuanpham-dev/termux-ubuntu/master/de-xfce -O ubuntu20-fs/usr/share/andronix/de-install > /dev/null
    ;;
esac

chmod +x ubuntu20-fs/root/.bash_profile
chmod +x ubuntu20-fs/root/.profile
chmod +x ubuntu20-fs/usr/local/bin/vnc
chmod +x ubuntu20-fs/usr/local/bin/vncpasswd
chmod +x ubuntu20-fs/usr/local/bin/vncserver-start
chmod +x ubuntu20-fs/usr/local/bin/vncserver-stop

echo "fixing shebang of $bin"
termux-fix-shebang $bin
echo "making $bin executable"
chmod +x $bin
echo "removing image for some space"
rm $tarball

bash $bin
