# create config file
```
[req]
default_bits       = 2048
default_keyfile    = distr.key
distinguished_name = req_distinguished_name
req_extensions     = req_ext
x509_extensions    = v3_ca

[req_distinguished_name]
countryName                 = Country Name (2 letter code)
countryName_default         = US
stateOrProvinceName         = State or Province Name (full name)
stateOrProvinceName_default = New York
localityName                = Locality Name (eg, city)
localityName_default        = Rochester
organizationName            = Organization Name (eg, company)
organizationName_default    = localhost
organizationalUnitName      = organizationalunit
organizationalUnitName_default = Development
commonName                  = Common Name (e.g. server FQDN or YOUR name)
commonName_default          = localhost
commonName_max              = 64

[req_ext]
subjectAltName = @alt_names

[v3_ca]
subjectAltName = @alt_names

[alt_names]
DNS.1   = distr
DNS.2   = 127.0.0.1
```

# generate ssl cert
```
sudo openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/distr.key -out /etc/ssl/certs/distr.crt -config cert.conf
```

# edit hosts
```
sudo vim /etc/hosts
127.0.0.1 distr
```

# create virtual host
```
server {
	listen 80;
	listen [::]:80;

    # SSL
    listen 443 ssl default_server;
    listen [::]:443 ssl default_server;
    ssl_certificate /etc/ssl/certs/distr.crt;
    ssl_certificate_key /etc/ssl/private/distr.key;
    ssl_protocols TLSv1.2 TLSv1.1 TLSv1;

	root /var/www/html/;
	index index.php index.html;
	sendfile off;
	client_max_body_size 64m;
	charset utf-8;
	server_name distr;

	location / {
		try_files $uri $uri/ /index.php?$query_string;
	}

	location /api/ {
		try_files $uri $uri/ /api/dev/index.php?$query_string;
	}

	location ~ \.php$ {
		fastcgi_split_path_info ^(.+\.php)(/.+)$;
		fastcgi_pass unix:/var/run/php/php7.4-fpm.sock;
		# arch fastcgi_pass unix:/var/run/php-fpm7/php-fpm.sock;
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

# reload NGINX
```
sudo systemctl reload nginx.service
```
