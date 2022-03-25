# turn off system beep sounds (GNOME)
```
dconf write /org/gnome/desktop/sound/event-sounds "false"
```

# SSH
### Generate
```
ssh-keygen -t rsa -b 4096 -C "developer.lenar@gmail.com"
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_rsa
cat ~/.ssh/id_rsa.pub
```
### check connect
```
Github
ssh -T git@github.com
GitLab
ssh -T git@dev.cb-server.com
```

# SWAP
### изменить размер swap-файла
```
swapon --show
NAME      TYPE SIZE USED PRIO
/swapfile file   2G   0B   -2

sudo swapoff /swapfile
sudo fallocate -l 8G /swapfile

sudo mkswap /swapfile
mkswap: /swapfile: warning: wiping old swap signature.
Setting up swapspace version 1, size = 4 GiB (4294967296 bytes)
no label, UUID=c50b27b0-a530-4dd0-9377-aa28eabf3957

sudo swapon /swapfile

access
sudo chmod 600 /swapfile
```

# sysctl.conf
```
ubuntu
sudo -s
echo "net.ipv4.ip_default_ttl=65" >> /etc/sysctl.conf
echo "vm.swappiness=10" >> /etc/sysctl.conf
echo "fs.inotify.max_user_watches=524288" >> /etc/sysctl.conf
sysctl --system

arch
sudo -s
echo "net.ipv4.ip_default_ttl=65" >> /etc/sysctl.d/99-sysctl.conf
echo "vm.swappiness=10" >> /etc/sysctl.d/99-sysctl.conf
sysctl --system
```



# Mount
```
sudo blkid
sudo mkdir /mnt/hdd1tb
sudo mousepad /etc/fstab
UUID="7ECCC7F5CCC7A62D" /mnt/hdd1tb ntfs rw,nls=utf8,gid=plugdev,umask=0002 0 0
sudo mount -a
```
