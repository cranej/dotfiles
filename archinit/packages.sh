#! /bin/sh

pacman -Sy --noconfirm sudo git zsh xorg xorg-server xorg-server-utils xorg-xinit i3
pacman -Sy --noconfirm scrot feh rxvt-unicode dmenu pass xdotool firefox openssh adobe-source-han-sans-otc-fonts
pacman -Sy --noconfirm acpi networkmanager network-manager-applet alsa-utils
pacman -Sy --noconfirm fcitx fcitx-gtk2 fcitx-gtk3 fcitx-configtool fcitx-libpinyin
pacman -Sy --noconfirm transmission-gtk goldendict udiskie mutt offlineimap msmtp cantarell-fonts

useradd -m cranej
echo Set password for cranej:
passwd cranej
