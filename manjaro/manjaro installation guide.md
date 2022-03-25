# mariadb (10.5 latest stable)
sudo pacman -S mariadb
sudo mariadb-install-db --user=mysql --basedir=/usr --datadir=/var/lib/mysql
sudo systemctl enable mariadb.service
sudo systemctl start mariadb.service
sudo mysql_secure_installation
sudo systemctl restart mariadb.service

# easy
sudo pacman -S nginx    (1.18.0 latest stable)
sudo pacman -S openssl
sudo pacman -S php      (7.4.10 latest stable)
sudo pacman -S php-fpm php-gd php-intl php-sqlite php-pgsql php-cgi php-dblib php-imap php-odbc php-tidy
sudo pacman -S xdebug   (2.9.6 latest stable)
```
sudo gedit /etc/php/conf.d/xdebug.ini
zend_extension=xdebug.so
xdebug.remote_enable=on
xdebug.remote_host=127.0.0.1
xdebug.remote_port=9000
xdebug.remote_handler=dbgp
xdebug.cli_color = 2

Verify if the extension is loaded:
php -r "var_dump(extension_loaded('xdebug'));"
bool(true)
```

sudo systemctl start php-fpm
sudo systemctl start nginx

sudo gedit /etc/php/php.ini
```
extension=bz2
extension=iconv
extension=imap
extension=mysqli
extension=pdo_mysql
extension=zip
mysqli.allow_local_infile = On
session.save_path = "/tmp"
open_basedir= /srv/http/:/home/:/tmp/:/usr/share/pear/:/usr/share/webapps/:/etc/webapps/:/usr/share/nginx/html
```
sudo mkdir /etc/nginx/sites-available /etc/nginx/sites-enabled
sudo mv /etc/nginx/nginx.conf /etc/nginx/nginx.conf.bak
sudo leafpad /etc/nginx/nginx.conf
```
user http;

worker_processes  2;

#error_log  logs/error.log;
#error_log  logs/error.log  notice;
#error_log  logs/error.log  info;
#pid        logs/nginx.pid;

events {
    worker_connections  1024;
}

http {
    include       mime.types;
    default_type  application/octet-stream;
    sendfile        on;

    #tcp_nopush     on;
    #keepalive_timeout  0;

    keepalive_timeout  65;

    gzip  on;

    types_hash_max_size 4096;

    server {
        listen       80;
        server_name  localhost;
        root   /usr/share/nginx/html;
        charset utf-8;
        location / {
            index  index.php index.html index.htm;
            autoindex on;
            autoindex_exact_size off;
            autoindex_localtime on;
        }

        location /phpmyadmin {
            rewrite ^/* /phpMyAdmin last;
        }

        error_page  404              /404.html;
        # redirect server error pages to the static page /50x.html
        error_page   500 502 503 504  /50x.html;

        location = /50x.html {
            root   /usr/share/nginx/html;
        }

        location ~ \.php$ {
            #fastcgi_pass 127.0.0.1:9000; (зависит от конфигурации сокета вашего php-fpm)
            fastcgi_pass unix:/run/php-fpm/php-fpm.sock;
            fastcgi_index index.php;
            include fastcgi.conf;
        }

        location ~ /\.ht {
            deny  all;
        }
    }
include /etc/nginx/sites-enabled/*.conf;
}
```
sudo systemctl restart php-fpm
sudo systemctl restart nginx

добавить службы в автозагрузку
sudo systemctl enable php-fpm
sudo systemctl enable nginx

# Включение виртуальных хостов на Nginx
sudo leafpad /etc/nginx/sites-available/sym.conf
```
server {
    listen 80;
    server_name sym.loc;
    access_log /var/log/nginx/sym.loc.access.log;
    error_log /var/log/nginx/sym.loc.error.log;
    root /usr/share/nginx/www/public/;

    location / {
        index index.html index.htm index.php;
        autoindex on;
        autoindex_exact_size off;
        autoindex_localtime on;
#        try_files $uri $uri/ /index.html;
    }

    location /api/ {
        try_files $uri $uri/ /api/index.php;
#        try_files $uri $uri/ index.php /index.php?$args;
    }

    location /phpmyadmin {
        rewrite ^/* /phpMyAdmin last;
    }

    location ~ \.php$ {
        #fastcgi_pass 127.0.0.1:9000; (зависит от конфигурации сокета вашего php-fpm)
        fastcgi_pass unix:/run/php-fpm/php-fpm.sock;
        fastcgi_index index.php;
        include fastcgi.conf;
    }
}
```
sudo ln -s /etc/nginx/sites-available/sym.conf /etc/nginx/sites-enabled/
sudo systemctl restart nginx

# Docker
```
pacman -Ss docker
pacman -Ss docker-compose
sudo pacman -S docker docker-compose
sudo systemctl start docker
sudo systemctl enable docker
docker version
docker-compose version
sudo usermod -aG docker $USER
```

# Wine
```
sudo pacman -S wine winetricks wine-mono wine_gecko
sudo pacman -S playonlinux
```
