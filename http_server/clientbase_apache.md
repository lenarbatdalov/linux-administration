# рабочий на arch
```
cat /etc/httpd/conf/sites-available/distr-ssl.conf
<VirtualHost *:443>
    DocumentRoot "/srv/http/distr/"
    ServerName distr
    ServerAdmin webmaster@localhost

    ErrorLog "/var/log/httpd/distr-ssl-error_log"
    TransferLog "/var/log/httpd/distr-ssl-access_log"

    SSLEngine on
    SSLCertificateFile "/etc/httpd/conf/ssl/distr.crt"
    SSLCertificateKeyFile "/etc/httpd/conf/ssl/distr.key"

    <FilesMatch "\.(cgi|shtml|phtml|php)$">
        SSLOptions +StdEnvVars
    </FilesMatch>

    <Directory "/srv/http/cgi-bin">
        SSLOptions +StdEnvVars
    </Directory>

    BrowserMatch "MSIE [2-5]" \
            nokeepalive ssl-unclean-shutdown \
            downgrade-1.0 force-response-1.0

    CustomLog "/var/log/httpd/ssl_request_log" \
            "%t %h %{SSL_PROTOCOL}x %{SSL_CIPHER}x \"%r\" %b"

    <Directory "/srv/http/distr/">
        Options +Indexes +FollowSymLinks +ExecCGI
        AllowOverride All
        Order deny,allow
        Allow from all
        Require all granted
    </Directory>

    <Directory "/">
        Options +Indexes +FollowSymLinks +ExecCGI
        AllowOverride All
        Order deny,allow
        Allow from all
        Require all granted
    </Directory>
</VirtualHost>


cat /etc/httpd/conf/sites-available/distr.conf
<VirtualHost *:80>
    DocumentRoot "/srv/http/distr/"
    ServerName distr
    ServerAdmin webmaster@localhost

    ErrorLog "/var/log/httpd/distr-error_log"
    TransferLog "/var/log/httpd/access_log"

    <Directory "/">
        Options +Indexes +FollowSymLinks +ExecCGI
        AllowOverride All
        Order deny,allow
        Allow from all
        Require all granted
    </Directory>

    <Directory "/srv/http/distr/">
        Options +Indexes +FollowSymLinks +ExecCGI
        AllowOverride All
        Order deny,allow
        Allow from all
        Require all granted
    </Directory>
</VirtualHost>
```



```
/etc/apache2/sites-enabled$ cat cb.loc.conf

<VirtualHost *:80>
    <Directory /var/www/html/master/>
            AllowOverride All
            Options -Indexes +FollowSymLinks
    </Directory>
    ServerAdmin webmaster@localhost
    ServerName cb.loc
#    Redirect / https://cb.loc/
    DocumentRoot /var/www/html/master/
    ErrorLog ${APACHE_LOG_DIR}/error.log
    CustomLog ${APACHE_LOG_DIR}/access.log combined
    SSLEngine on
    SSLCertificateFile /etc/ssl/certs/apache-selfsigned.crt
    SSLCertificateKeyFile /etc/ssl/private/apache-selfsigned.key
</VirtualHost>

ПРОБНЫЙ
<VirtualHost *:80>
    DocumentRoot "/srv/http/distr/"
    ServerName distr
    ServerAdmin webmaster@localhost

    ErrorLog "/var/log/httpd/distr-error_log"
    TransferLog "/var/log/httpd/access_log"

    <Directory />
        Options -Indexes +FollowSymLinks
        # Options +Indexes +FollowSymLinks +ExecCGI
        AllowOverride All
        Order deny,allow
        Allow from all
        Require all granted
    </Directory>
</VirtualHost>
```

```
/etc/apache2/sites-enabled$ cat cb.loc-ssl.conf

<IfModule mod_ssl.c>
    <VirtualHost _default_:443>
        ServerAdmin webmaster@localhost

        <Directory /var/www/html/master/>
            AllowOverride All
            Options -Indexes +FollowSymLinks
        </Directory>

            DocumentRoot /var/www/html/master/

            ErrorLog ${APACHE_LOG_DIR}/error.log
            CustomLog ${APACHE_LOG_DIR}/access.log combined

            SSLEngine on

            SSLCertificateFile /etc/ssl/certs/apache-selfsigned.crt
            SSLCertificateKeyFile /etc/ssl/private/apache-selfsigned.key

            <FilesMatch "\.(cgi|shtml|phtml|php)$">
                            SSLOptions +StdEnvVars
            </FilesMatch>
            <Directory /usr/lib/cgi-bin>
                            SSLOptions +StdEnvVars
            </Directory>
        </VirtualHost>
</IfModule>
```
