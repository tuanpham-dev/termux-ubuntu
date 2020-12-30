LANG=en_US.UTF-8
LC_ALL=C
LANGUAGE=en_US

exit() {
  pkill dbus
  pkill ssh-agent
  pkill gpg-agent
  pkill pulseaudio
  vncserver -kill :1
  unset LD_PRELOAD
  unset -f exit
  exit
}
