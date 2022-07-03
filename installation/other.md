# gnome-keyring
```
yay -S gnome-keyring

kate /etc/pam.d/login
auth       optional     pam_gnome_keyring.so
session    optional     pam_gnome_keyring.so auto_start

kate ~/.zshrc
if [ -n "$DESKTOP_SESSION" ];then
    eval $(gnome-keyring-daemon --start)
    export SSH_AUTH_SOCK
fi

gnome-keyring-daemon -r -d

kate /etc/pam.d/passwd
password	optional	pam_gnome_keyring.so
```

# watchdog0 did not stop
```
vim /etc/systemd/system.conf
add
ShutdownWatchdogSec=10

vim /etc/default/grub
GRUB_CMDLINE_LINUX="reboot=acpi"
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
