# basic
```
sudo apt install nginx mariadb-server \
    php7.4-fpm php7.4-cli php7.4-curl php7.4-mysql php7.4-gd php7.4-mbstring php7.4-common php7.4-json php7.4-intl php7.4-xml php7.4-zip php7.4-sqlite3 php7.4-pgsql php-pear \
    php-xdebug \
    curl wget mc htop lnav gparted git \
    gedit kolourpaint sqlite sqlitebrowser telegram-desktop

sudo usermod -a -G www-data $USER
sudo chown -R www-data:www-data .
sudo chmod -R g+rw .
```

# zsh
```
sudo chsh -s $(which zsh)
ZSH_THEME="eastwood"
```

# swap
```
===== for ext4
swapon --show
sudo swapoff /swapfile
sudo fallocate -l 8G /swapfile
sudo mkswap /swapfile
sudo swapon /swapfile

===== for btrfs
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

# sysctl
```
sudo -s
echo "net.ipv4.ip_default_ttl=65" >> /etc/sysctl.conf
echo "vm.swappiness=10" >> /etc/sysctl.conf
echo "vfs_cache_pressure = 50" >> /etc/sysctl.conf
echo "fs.inotify.max_user_watches=524288" >> /etc/sysctl.conf
sysctl --system
```

# ssh
```
ssh-keygen -t rsa -b 4096 -C "developer.lenar@gmail.com"
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_rsa
cat ~/.ssh/id_rsa.pub

ssh -T git@github.com
ssh -T git@dev.cb-server.com
ssh -T git@bitbucket.org
```

# git
```
git config --global user.email "developer.lenar@gmail.com"
git config --global user.name "Lenar Batdalov"
git config --global pull.ff only
git config --global init.defaultBranch master
```

# composer
```
https://getcomposer.org/download/
sudo mv composer.phar /usr/local/bin/composer
```

# xdebug
```
sudo apt install php-xdebug -y
sudo gedit /etc/php/7.4/mods-available/xdebug.ini

v2
zend_extension=xdebug.so
xdebug.remote_enable = 1
xdebug.remote_autostart = 1
xdebug.remote_host=127.0.0.1
xdebug.remote_port=9000
xdebug.profiler_enable = 0
xdebug.log_level = 10
xdebug.mode = develop

v3
zend_extension=xdebug.so
xdebug.start_with_request=yes
xdebug.discover_client_host=true
xdebug.remote_cookie_expire_time=3600
xdebug.client_port=9000
xdebug.remote_handler=dbgp
xdebug.client_host=127.0.0.1
xdebug.mode=debug
;xdebug.log=10
xdebug.idekey=VSCODE
;xdebug.idekey=PHPSTORM

Verify if the extension is loaded:
php -r "var_dump(extension_loaded('xdebug'));"
bool(true)
```

# nodejs, npm, npx, yarn
```
https://github.com/nodesource/distributions/blob/master/README.md#installation-instructions
curl -sL https://deb.nodesource.com/setup_16.x | sudo -E bash -
sudo apt-get install -y nodejs

npm config set prefix ~/.npm
export PATH="$PATH:$HOME/.npm/bin"
source ~/.profile

npm install -g yarn
npm install -g @vue/cli
```

# Docker
```
https://docs.docker.com/install/linux/docker-ce/ubuntu/
https://docs.docker.com/compose/install/

sudo groupadd docker
sudo usermod -aG docker $USER
sudo chmod a+rwx /var/run/docker.sock
sudo chmod a+rwx /var/run/docker.pid
```

# Android studio
```
sudo apt-add-repository ppa:maarten-fonville/android-studio
sudo apt update
sudo apt install -y android-studio
```

# Flutter
```
https://flutter.dev/docs/get-started/install
sudo snap install flutter --classic
sudo snap install androidsdk
sudo snap install android-studio --classic
flutter config --android-studio-dir="/snap/android-studio/current/android-studio"

java
sudo apt install default-jre
sudo apt install default-jdk
sudo update-alternatives --config java
sudo update-alternatives --config javac
java -version
javac -version
```

# Postman
```
https://www.postman.com/downloads/
sudo tar -xzf Postman-linux-x64-5.3.2.tar.gz -C /opt
sudo ln -s /opt/Postman/app/Postman /usr/bin/postman

cat > /usr/share/applications/postman.desktop <<EOL
[Desktop Entry]
Encoding=UTF-8
Name=Postman
Exec=postman
Icon=/opt/Postman/app/resources/app/assets/icon.png
Terminal=false
Type=Application
Categories=Development;
EOL
```

# PostgreSQL
```
sudo apt-get install curl ca-certificates gnupg
curl https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -

sudo sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list'

sudo apt-get update
sudo apt-get install postgresql-11 pgadmin4

psql --version
sudo service postgresql status

Контейнер Docker, содержащий pgAdmin, работающий в режиме сервера по HTTP или HTTPS, доступен в Docker Hub.
```

# Rabbitmq
```
sudo apt-get install rabbitmq-server -y --fix-missing
sudo service rabbitmq-server status
sudo apt install php-amqp
sudo service apache2 restart
```

# Redis
```
sudo apt install redis-server
sudo systemctl status redis
redis-cli
ping

sudo apt install php-redis
sudo service apache2 restart
```

# other
```
sudo apt-get install jstest-gtk -y
sudo apt-get install joystick -y
```
