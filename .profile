export LANG=en_US.UTF-8
export LC_ALL=C
export LANGUAGE=en_US

if [ ! -z `which vncserver` ]; then
  GEO="" PORT=1 vnc
fi

exit() {
  pkill dbus
  pkill ssh-agent
  pkill gpg-agent
  pkill pulseaudio

  if [ ! -z `which vncserver` ]; then
    vncserver -kill :1
  fi
  
  unset LD_PRELOAD
  unset -f exit
  exit
}
