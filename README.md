# Install Ubuntu20 on Termux Android

This installs Ubuntu 20 with xfce4 desktop on Termux. All scripts are from Andronix, I just compose and edit them to make the installer easier and smoother. It includes:

- [x] Ubuntu 20
- [x] XFCE4 Desktop
- [x] TigerVNC Server
- [x] Non-root Account Creation
- [x] Audio Support
- [x] Chromium Browser

## Installation

Copy and paste this command to Termux:

```bash
pkg update -y && pkg install wget curl proot tar -y && wget https://raw.githubusercontent.com/tuanpham-dev/termux-ubuntu/master/ubuntu.sh && chmod +x ubuntu.sh && bash ubuntu.sh
```

## Run

### Start Ubuntu

After installation, on Termux, you can execute this command to run ubuntu:

```bash
./start-ubuntu20.sh
```

### Exit Ubuntu

To exit ubuntu you can simply run `exit` command. This will stop vncserver and some services.

```
exit
```

### Start VNC Server

On Ubuntu, run this command to start VNC Server:

```bash
vncserver-start
```

Then you can use VNC Client to connect to `127.0.0.1:1` or `127.0.0.1:5901`

### Stop VNC Server

On Ubuntu, run this command to stop VNC Server:

```bash
vncserver-stop
```

## Other

### Install VS Code

VSCode ARM is now officially supported by Microsoft. You can install it with following commands:

```bash
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
sudo install -o root -g root -m 644 packages.microsoft.gpg /etc/apt/trusted.gpg.d/
sudo sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/trusted.gpg.d/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
sudo apt install apt-transport-https
sudo apt update
sudo apt install code # or code-insiders
```

### Theme

- Prof-XFCE-theme is the best for me. You can download it here:

```
https://www.gnome-look.org/p/1334420/
```

- Vimix icon is nice. You can download it here:

```
https://www.gnome-look.org/p/1334420/
```

- After download \*.tar.xz file you can extract it and copy to theme/icons folder:

```
tar -xf "Prof--XFCE- 2.1.tar.gz"
cp -rp "Prof--XFCE- 2.1" ~/.local/share/icons
tar -xf Vimix.tar.xz
cp -rp Vimix ~/.local/share/icons/
```
