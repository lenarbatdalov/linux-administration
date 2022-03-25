# Apache
```
sudo systemctl disable nginx

pacman -Syu
pacman -S apache

sudo gedit /etc/httpd/conf/httpd.conf
#LoadModule mpm_event_module modules/mod_mpm_event.so
LoadModule mpm_prefork_module modules/mod_mpm_prefork.so
добавить в конец
IncludeOptional conf/sites-enabled/*.conf
IncludeOptional conf/mods-enabled/*.conf
ServerName localhost

sudo gedit /etc/httpd/conf/extra/php.conf
LoadModule php7_module modules/libphp7.so
Include conf/extra/php7_module.conf
AddHandler application/x-httpd-php .php

sudo mkdir /etc/httpd/conf/sites-available
sudo mkdir /etc/httpd/conf/sites-enabled
sudo mkdir /etc/httpd/conf/mods-enabled

sudo ln -s /etc/httpd/conf/extra/php.conf /etc/httpd/conf/mods-enabled/php.conf

sudo systemctl enable httpd
sudo systemctl restart httpd
sudo systemctl status httpd
```

# Apache a2eniste и a2diste
```
sudo gedit a2ensite
#!/bin/bash
if test -d /etc/httpd/conf/sites-available && test -d /etc/httpd/conf/sites-enabled  ; then
echo "-------------------------------"
else
mkdir /etc/httpd/conf/sites-available
mkdir /etc/httpd/conf/sites-enabled
fi
 
avail=/etc/httpd/conf/sites-available/$1.conf
enabled=/etc/httpd/conf/sites-enabled
site=`ls /etc/httpd/conf/sites-available/`
 
if [ "$#" != "1" ]; then
        echo "Use script: n2ensite virtual_site"
        echo -e "\nAvailable virtual hosts:\n$site"
        exit 0
else
if test -e $avail; then
sudo ln -s $avail $enabled
else
echo -e "$avail virtual host does not exist! Please create one!\n$site"
exit 0
fi
if test -e $enabled/$1.conf; then
echo "Success!! Now restart Apache server: sudo systemctl restart httpd"
else
echo  -e "Virtual host $avail does not exist!\nPlease see avail virtual hosts:\n$site"
exit 0
fi
fi

sudo gedit a2dissite
#!/bin/bash
avail=/etc/httpd/conf/sites-enabled/$1.conf
enabled=/etc/httpd/conf/sites-enabled
site=`ls /etc/httpd/conf/sites-enabled`
 
if [ "$#" != "1" ]; then
        echo "Use script: n2dissite virtual_site"
        echo -e "\nAvailable virtual hosts: \n$site"
        exit 0
else
if test -e $avail; then
sudo rm  $avail
else
echo -e "$avail virtual host does not exist! Exiting"
exit 0
fi
if test -e $enabled/$1.conf; then
echo "Error!! Could not remove $avail virtual host!"
else
echo  -e "Success! $avail has been removed!\nsudo systemctl restart httpd"
exit 0
fi
fi

sudo chmod +x a2ensite a2dissite
sudo cp a2ensite a2dissite /usr/local/bin/
```

# apache vhost
```
sudo gedit /etc/httpd/conf/sites-available/test.conf
<VirtualHost *:80>
        DocumentRoot "/srv/http"
        ServerName ts.loc
        ServerAdmin you@example.com
        ErrorLog "/var/log/httpd/localhost-error_log"
        TransferLog "/var/log/httpd/localhost-access_log"
 
<Directory />
    Options +Indexes +FollowSymLinks +ExecCGI
    AllowOverride All
    Order deny,allow
    Allow from all
Require all granted
</Directory>
 
</VirtualHost>

sudo gedit /etc/hosts
127.0.0.1  ts.loc

sudo a2ensite test
sudo systemctl restart httpd
```

# Mysql
```
pacman -S mysql
mysql_install_db --user=mysql --basedir=/usr --datadir=/var/lib/mysql
systemctl enable mysqld
systemctl start mysqld
systemctl status mysqld
```

# Php
```
sudo pacman -S php php-apache
```

