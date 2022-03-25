# ubuntu
```
sudo gedit /etc/nginx/conf.d/

server {
	listen 80;
	listen [::]:80;
	root /var/www/html/;
	index index.php index.html;
	sendfile off;
	client_max_body_size 64m;
	charset utf-8;
	server_name _;

	location / {
		try_files $uri $uri/ /index.php?$query_string;
	}

	location ~ \.php$ {
		fastcgi_split_path_info ^(.+\.php)(/.+)$;
		fastcgi_pass unix:/var/run/php/php7.4-fpm.sock;
		fastcgi_index index.php;
		include fastcgi_params;
		fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
		fastcgi_intercept_errors off;
		fastcgi_buffer_size 16k;
		fastcgi_buffers 4 16k;
		fastcgi_connect_timeout 300;
		fastcgi_send_timeout 300;
		fastcgi_read_timeout 300;
	}

	location ~ /\.ht {
		deny all;
	}
}

sudo nginx -t
sudo systemctl restart nginx

sudo gedit /etc/hosts
127.0.0.1 test.loc
```

# manjaro
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

# ssl
```
openssl version

mkdir ~/local_ssl
cd local_ssl
openssl req -x509 -sha256 -nodes -newkey rsa:2048 -days 365 -keyout localhost.key -out localhost.crt

Country Name (2 letter code) [AU]:RU
State or Province Name (full name) [Some-State]:Tatarstan
Locality Name (eg, city) []:Kazan
Organization Name (eg, company) [Internet Widgits Pty Ltd]:Lenar
Organizational Unit Name (eg, section) []:eg
Common Name (e.g. server FQDN or YOUR name) []:Lenar
Email Address []:batl@clientbase.ru

server {
	listen 80 default_server;
	listen [::]:80 default_server;
	root /var/www/html/;
	index index.php index.html;
	sendfile off;
	client_max_body_size 64m;
	charset utf-8;
	server_name _;

	listen 443 ssl default_server;
	listen [::]:443 ssl default_server;
	ssl_certificate /home/user/local_ssl/localhost.crt;
	ssl_certificate_key /home/user/local_ssl/localhost.key;
	ssl_ciphers          HIGH:!aNULL:!MD5;

	location / {
		try_files $uri $uri/ /index.php?$query_string;
	}
	location ~ \.php$ {
		fastcgi_split_path_info ^(.+\.php)(/.+)$;
		fastcgi_pass unix:/var/run/php/php7.4-fpm.sock;
		fastcgi_index index.php;
		include fastcgi_params;
		fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
		fastcgi_intercept_errors off;
		fastcgi_buffer_size 16k;
		fastcgi_buffers 4 16k;
		fastcgi_connect_timeout 300;
		fastcgi_send_timeout 300;
		fastcgi_read_timeout 300;
	}
	location ~ /\.ht {
		deny all;
	}
}
```
