```
yay -S curl wget mc htop lnav gparted git zim zsh \
    kolourpaint sqlite sqlitebrowser telegram-desktop \
    php7 php7-fpm php7-apcu php7-cgi php7-dblib php7-embed php7-enchant \
    php7-gd php7-imap php7-intl php7-odbc php7-pgsql php7-phpdbg \
    php7-pspell php7-snmp php7-sodium php7-sqlite php7-tidy php7-xsl \
    nginx mariadb nodejs npm docker docker-compose \
    google-chrome \
    visual-studio-code-bin \
    dropbox

sudo usermod -a -G http $USER
sudo mariadb-install-db --user=mysql --basedir=/usr --datadir=/var/lib/mysql

sudo vim /etc/default/grub
GRUB_TIMEOUT=0.5
GRUB_TIMEOUT_STYLE=hidden
sudo grub-mkconfig -o /boot/grub/grub.cfg

sudo systemctl enable \
    docker.service \
    nginx.service \
    php-fpm7.service \
    mariadb.service

sudo systemctl start \
    docker.service \
    nginx.service \
    php-fpm7.service \
    mariadb.service

sudo usermod -aG docker $USER
sudo chmod a+rwx /var/run/docker.sock
sudo chmod a+rwx /var/run/docker.pid

sudo ln -s /usr/bin/php7 /usr/bin/php


xset -b
sudo echo 'xset -b' >> ~/.xprofile


sudo -s
vim /etc/sysctl.d/addit.conf
net.ipv4.ip_default_ttl=65
vm.swappiness=10
vfs_cache_pressure=50
fs.inotify.max_user_watches=524288
sysctl --system
exit


https://getcomposer.org/download/
sudo mv composer.phar /usr/local/bin/composer

wget https://codeload.github.com/xdebug/xdebug/tar.gz/refs/tags/2.9.2 -O xdebug-2.9.2.tar.gz
tar -xzf xdebug-2.9.2.tar.gz
cd xdebug-2.9.2
phpize7
./configure --enable-xdebug
make
sudo make install
sudo vim /etc/php7/conf.d/xdebug.ini
zend_extension=xdebug.so
xdebug.remote_enable = 1
xdebug.remote_autostart = 1
xdebug.remote_host=127.0.0.1
xdebug.remote_port=9000
xdebug.profiler_enable = 0
xdebug.log_level = 10
xdebug.mode = develop
```


```
ssh-keygen -t rsa -b 4096 -C "developer.lenar@gmail.com"
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_rsa
cat ~/.ssh/id_rsa.pub

git config --global user.email "developer.lenar@gmail.com"
git config --global user.name "Lenar Batdalov"
git config --global pull.ff only
git config --global init.defaultBranch master
```
