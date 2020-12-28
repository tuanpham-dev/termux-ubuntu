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

You can run APT script from headmelted to add repository:

```bash
. <( wget -O - https://code.headmelted.com/installers/apt.sh )
```

You will get error and now you can install with this command:

```bash
sudo apt install code-oss
```
