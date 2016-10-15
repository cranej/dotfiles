#! /bin/sh

pacman -Sy --noconfirm sudo git zsh xorg xorg-server xorg-server-utils xorg-xinit i3
pacman -Sy --noconfirm rxvt-unicode dmenu firefox openssh adobe-source-han-sans-otc-fonts
pacman -Sy --noconfirm networkmanager network-manager-applet
pacman -Sy --noconfirm transmission-gtk goldendict udiskie mutt offlineimap msmtp cantarell-fonts

useradd -m cranej
echo Set password for cranej:
passwd cranej
