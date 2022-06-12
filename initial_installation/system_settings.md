# System settings and configuration
### git
```zsh
git config --global user.email "developer.lenar@gmail.com"
git config --global user.name "Ленар Батдалов"
git config --global pull.ff only
git config --global init.defaultBranch master
```

### Swap
for ext4
```zsh
swapon --show
sudo swapoff /swapfile
sudo fallocate -l 8G /swapfile
sudo mkswap /swapfile
sudo swapon /swapfile
```

for btrfs
```zsh
sudo mount /dev/sda1 /mnt
sudo btrfs sub create /mnt/@swap
sudo umount /mnt
sudo mkdir /swap
sudo mount -o subvol=@swap /dev/sda1 /swap
sudo touch /swap/swapfile
sudo chmod 600 /swap/swapfile
sudo chattr +C /swap/swapfile
sudo fallocate /swap/swapfile -l8g
sudo mkswap /swap/swapfile
sudo swapon /swap/swapfile
sudo gedit /etc/fstab       /swap/swapfile none swap sw 0 0
```

### Sysctl
```zsh
sudo -s
echo "net.ipv4.ip_default_ttl=65" >> /etc/sysctl.conf
echo "vm.swappiness=10" >> /etc/sysctl.conf
echo "vfs_cache_pressure = 50" >> /etc/sysctl.conf
echo "fs.inotify.max_user_watches=524288" >> /etc/sysctl.conf
sysctl --system
```
