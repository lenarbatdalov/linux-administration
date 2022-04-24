# odin (elementary os 6)
```
Отключить beep sound
dconf write /org/gnome/desktop/sound/event-sounds "false"

Добавить extract/compress в файловый менеджер
sudo apt install --reinstall file-roller
sudo apt install io.elementary.contractor.file-roller

Установка virtualbox
sudo apt-get remove virtualbox-\*
sudo apt-get purge virtualbox-\*
sudo apt autoremove
sudo apt install linux-headers-$(uname -r)
sudo apt install virtualbox -y
reboot

Установка steam
sudo dpkg --add-architecture i386
sudo apt update
sudo apt install wget gdebi-core libgl1-mesa-glx:i386
```
