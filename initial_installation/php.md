# PHP
### install
```zsh
sudo apt install nginx mariadb-server \
    php7.4-fpm \
    php7.4-cli \
    php7.4-curl \
    php7.4-mysql \
    php7.4-gd \
    php7.4-mbstring \
    php7.4-common \
    php7.4-json \
    php7.4-intl \
    php7.4-xml \
    php7.4-zip \
    php7.4-sqlite3 \
    php7.4-pgsql \
    php-pear \
    php-xdebug
```

### composer
```zsh
https://getcomposer.org/download/
sudo mv composer.phar /usr/local/bin/composer
```

### xdebug
```ini
sudo mousepad /etc/php/7.4/mods-available/xdebug.ini

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

### php settings
```zsh
sudo mousepad /etc/php/7.4/cli/php.ini
sudo mousepad /etc/php/7.4/fpm/php.ini

post_max_size = 128M
upload_max_filesize = 128M
session.gc_maxlifetime = 86400
```

### allow
```zsh
sudo usermod -a -G www-data $USER
sudo chown -R www-data:www-data /var/www/html
sudo chmod -R g+rw /var/www/html
```
