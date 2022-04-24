# install php extension

### redis
```manjaro
aur -> software manager -> search -> php-redis -> build
dependency -> php-igbinary -> install (required)
sudo gedit /etc/php/conf.d/igbinary.ini -> uncomment (extension=igbinary)
sudo gedit /etc/php/conf.d/redis.ini -> uncomment (extension=redis)
```

### amqp - rabbitmq
```manjaro
aur -> software manager -> search -> php-amqp -> build
sudo gedit /etc/php/conf.d/amqp.ini -> uncomment (extension=amqp)
```


```debian
sudo touch /etc/php/7.3/cli/conf.d/99-local.ini
sudo chmod 777 /etc/php/7.3/cli/conf.d/99-local.ini
```

```debian
[XDebug]

xdebug.remote_enable=1
xdebug.remote_host=127.0.0.1
xdebug.remote_port=9000 ; Порт, который мы указали в launch.json
xdebug.idekey=code
xdebug.remote_autostart=1
xdebug.remote_connect_back = 1
xdebug.profiler_enable = 0
;xdebug.remote_handler="dbgp"
xdebug.profiler_enable_trigger = Off
xdebug.show_local_vars=0
```

# PHP Sniffer
```debian
В PHP в качестве линтера используется PHP_CodeSniffer.
composer global require "squizlabs/php_codesniffer=*"
phpcs --version

Выполнить проверку кода в терминале можно с помощью команды phpcs, явно указав стандарт, который мы хотим использовать, и путь для проверки:
phpcs --standard=PSR12 <dirname>
```


#   настроить php модули
```
Проверить версию установленного на сервере интерпретатора PHP:   php  -v

вывод информации как о версии PHP на виртуальном VPS сервере, так и о его параметрах:    php -i

Для того чтобы посмотреть что Вы можете поставить прямо сейчас нужно сделать:   apt-cache search php

sudo apt-get install php-xdebug
service apache2 restart

посмотреть список модулей php который прямо сейчас подключены:  php -m
```

#   модули php для работы cb
```
apt-cache search php

sudo apt-get install php-gd
sudo apt-get install php-mbstring
sudo apt-get install php-mysql
sudo apt-get install php-curl
sudo apt-get install php-xml
sudo apt-get install php-json
sudo apt-get install php-cgi
sudo apt-get install php-cli
sudo apt-get install libphp-snoopy
sudo apt-get install php-fpm
sudo apt-get install php-http
sudo apt-get install php-image-text

sudo service apache2 restart
```

#   mcrypt
```
php -m | grep mcrypt

apt-get install php-mcrypt  // если не получилось, то дальше 

sudo apt-get -y install gcc make autoconf libc-dev pkg-config
sudo apt-get -y install php7.2-dev
sudo apt-get -y install libmcrypt-dev
sudo pecl install mcrypt-1.0.1


mcedit /etc/php/7.2/mods-available/mcrypt.ini
; configuration for php mcrypt module
; priority=20
extension=mcrypt.so


/etc/php/7.2/apache2/conf.d/@20-mcrypt.ini
; configuration for php mcrypt module
; priority=20
extension=mcrypt.so

/etc/php/7.2/cli/conf.d/@20-mcrypt.ini
; configuration for php mcrypt module
; priority=20
extension=mcrypt.so

sudo service apache2 restart

php -m | grep mcrypt 	// видим mcrypt
```

