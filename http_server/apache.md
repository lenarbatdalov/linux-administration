```
sudo a2enmod rewrite

sudo gedit /etc/apache2/sites-available/test.loc.conf

<VirtualHost *:80>
    <Directory /var/www/html/test/>
        Options Indexes FollowSymlinks
        AllowOverride All
        Require all granted
    </Directory>
    ServerAdmin webmaster@localhost
    ServerName test.loc
    DocumentRoot /var/www/html/test/
    ErrorLog ${APACHE_LOG_DIR}/error.log
    CustomLog ${APACHE_LOG_DIR}/access.log combined

    <Directory /var/www/html>
            #Options -Indexes
            AllowOverride All
            #Require all granted
            Options -Indexes +FollowSymLinks
    </Directory>
</VirtualHost>

sudo a2ensite test.loc
sudo service apache2 restart

sudo gedit /etc/hosts
127.0.0.1	test.loc
```


# ARCH
```
sudo pacman -S apache
sudo systemctl start httpd
sudo systemctl status httpd

sudo pacman -S php php-apache php-imap

sudo pacman -S mysql
sudo mysql_install_db --user=mysql --basedir=/usr --datadir=/var/lib/mysql
sudo systemctl start mysqld
sudo systemctl status mysqld


Следующие настройки, в первую очередь, относятся к веб-серверу Apache для обеспечения динамического интерфейса для виртуального хостинга со скриптовым языком PHP, виртуальных хостов SSL или не-SSL; это можно сделать модификацией файла настроек службы httpd.
Для начала откройте конфигурационный файл Apache вашим любимым текстовым редактором.

sudo vim /etc/httpd/conf/httpd.conf
IncludeOptional conf/sites-enabled/*.conf
IncludeOptional conf/mods-enabled/*.conf

sudo mkdir /etc/httpd/conf/sites-available
sudo mkdir /etc/httpd/conf/sites-enabled
sudo mkdir /etc/httpd/conf/mods-enabled
Путь sites-available содержит файлы настроек всех виртуальных хостов, которые не активированы на Apache, но следующий скрипт Bash будет использовать эту директорию для связи и задействования веб-сайтов, которые там расположены.

Создание команд Apache a2eniste и a2diste
9. Теперь время создать скрипты Apache a2ensite и a2dissite, которые будут выполнять команды по включению и отключению файлов настроек виртуальных хостов. Наберите команду cd для возвращения в вашу домашнюю директорию и создайте a2eniste и a2dissite используя ваш любимый редактор.

sudo vim a2ensite

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


sudo vim a2dissite

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

sudo cp a2ensite a2dissite /usr/local/bin/
sudo chmod +x /usr/local/bin/a2ensite /usr/local/bin/a2dissite

sudo systemctl restart httpd

Использование путей sites-available и sites-enable, здорово упрощает работу по включению и отключению веб-сайтов и также сохраняет конфигурационные файлы всех веб-сайтов в независимости от того, активированы они или нет.

Следующим шагом мы собираемся сконструировать первый виртуальный хост, который указывает на дефолтный localhost с дефолтным путём DocumentRoot для обслуживания файлов веб-сайта (/srv/http).

sudo vim /etc/httpd/conf/sites-available/localhost.conf

<VirtualHost *:80>
    DocumentRoot "/srv/http"
    ServerName localhost
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

sudo a2ensite localhost
sudo systemctl restart httpd


Включение SSL с виртуальным хостингом на LAMP (опционально)
Этот шаг можно пропустить. На локальном сервере (localhost) этот шаг рекомендуется пропустить.
SSL (Secure Sockets Layer) – это протокол, созданный для безопасных HTTP соединений по сети или в Интернете, который делает так, что поток данных переправляется через безопасный канал, используя симметричные/ассиметричные ключи шифрования, которые предоставляются в Arch Linux пакетом OpenSSL.

14. По умолчанию модоуль SSL на включен на Apache в Arch Linux и может быть активирован раскомментированием строки модуля mod_ssl.so в конфигурационном файле httpd.conf и Include httpd-ssl.conf файла, размещённом в директории httpd extra.

Но для упрощения, мы собираемся создать новый модульный файл для SSL в директории mods-enabled, главный конфигурационный файл Apache оставить нетронутым. Создайте следующий файл для модуля SSL и добавьте следующее содержимое.

sudo vim /etc/httpd/conf/mods-enabled/ssl.conf

LoadModule ssl_module modules/mod_ssl.so
LoadModule socache_shmcb_module modules/mod_socache_shmcb.so

Listen 443

SSLCipherSuite HIGH:MEDIUM:!aNULL:!MD5
SSLPassPhraseDialog  builtin
SSLSessionCache        "shmcb:/run/httpd/ssl_scache(512000)"
SSLSessionCacheTimeout  300

15. Теперь создайте файл виртуального хоста, который указывает на то же самое имя localhost, но использует в это же время конфигурационный файл сервера SSL и слега измените его имя на то, которое бы напоминало вам, что он здесь для localhost с SSL.

sudo vim /etc/httpd/conf/sites-available/localhost-ssl.conf

<VirtualHost *:443>
    DocumentRoot "/srv/http"
    ServerName localhost
    ServerAdmin you@example.com
    ErrorLog "/var/log/httpd/localhost-ssl-error_log"
    TransferLog "/var/log/httpd/localhost-ssl-access_log"

    SSLEngine on

    SSLCertificateFile "/etc/httpd/conf/ssl/localhost.crt"
    SSLCertificateKeyFile "/etc/httpd/conf/ssl/localhost.key"

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

    <Directory />

        Options +Indexes +FollowSymLinks +ExecCGI
        AllowOverride All
        Order deny,allow
        Allow from all
        Require all granted
    </Directory>
</VirtualHost>


sudo pacman -S openssl
Затем создайте следующий баш скрипт, который автоматически создаёт и сохраняет все ваши сертификаты и ключи Apache в системной директории /etc/httpd/conf/ssl/.

vim apache_gen_ssl
Добавьте в этот файл следующий контент, сохраните его и сделайте исполнимым.

#!/bin/bash
mkdir /etc/httpd/conf/ssl
cd /etc/httpd/conf/ssl
echo -e "Enter your virtual host FQDN: \nThis will generate the default name for Nginx  SSL certificate!"
read cert
openssl genpkey -algorithm RSA -pkeyopt rsa_keygen_bits:2048 -out $cert.key
chmod 600 $cert.key
openssl req -new -key $cert.key -out $cert.csr
openssl x509 -req -days 365 -in $cert.csr -signkey $cert.key -out $cert.crt
echo -e " The certificate "$cert" has been generated!\nPlease link it to Apache SSL available website!"
ls -all /etc/httpd/conf/ssl
exit 0

sudo cp ./apache_gen_ssl  /usr/local/bin/
sudo chmod +x /usr/local/bin/apache_gen_ssl


Теперь сгенерируйте ваш сертификат и ключи запустив этот скрипт.
Предоставьте ваши SSL опции и не забудьте чтобы имя сертификата и общее имя соответствовали вашему официальному имени домена (FQDN).

sudo apache_gen_ssl
После того, как сертификат был создан, не забудьте изменить ваши настройки виртуального хоста для SSL: путь до сертификата и ключа, чтобы они соответствовали имени этого сертификата.

Для соответствия вышеприведённым настройкам, переименуем файлы сертификатов:

sudo mv /etc/httpd/conf/ssl/.crt /etc/httpd/conf/ssl/localhost.crt
sudo mv /etc/httpd/conf/ssl/.key /etc/httpd/conf/ssl/localhost.key

sudo a2ensite localhost-ssl
sudo systemctl restart httpd


Включение PHP 7 на Apache

sudo vim /etc/httpd/conf/httpd.conf

Должно получиться:
#LoadModule mpm_event_module modules/mod_mpm_event.so
LoadModule mpm_prefork_module modules/mod_mpm_prefork.so
LoadModule rewrite_module modules/mod_rewrite.so

sudo vim /etc/httpd/conf/extra/php.conf

LoadModule php7_module modules/libphp7.so
Include conf/extra/php7_module.conf
AddHandler application/x-httpd-php .php

sudo ln -s /etc/httpd/conf/extra/php.conf /etc/httpd/conf/mods-enabled/php.conf

sudo vim /srv/http/info.php

<?php
phpinfo();

sudo systemctl restart httpd

```

# other
### PhpMyAdmin
```
Шаг 8: Установка и настройка PhpMyAdmin
23. Если вы не мастер по командной строке MySQL и хотите простой удалённый доступ к СУБД MySQL через веб-интерфейс, тогда вам нужен установленный пакет phpMyAdmin на ваш Arch.

sudo pacman -S phpmyadmin
24. После того, как пакеты были установлены вам нужно включить некоторые расширения PHP (mysqli.so) и вы также можете включить другие модули, которые необходимы для будущих платформ CMS, к примеру openssl.so, imap.so или iconv.so и т.д..

sudo vim /etc/php/php.ini
Найдите и раскомментируйте следующие расширения.

extension=bz2.so
extension=iconv.so
extension=imap.so
extension=mysqli.so
extension=pdo_mysql.so
extension=zip.so
В этом же файле найдите строку

;session.save_path = "/tmp"
если она закоментирована, то раскоментируйте её, чтобы получилось

session.save_path = "/tmp"
Также в этом же файле найдите и укажите расположение для выражения open_basedir и добавьте системный путь phpMyAdmin (/etc/webapps/ и /usr/share/webapps/) чтобы убедиться, что PHP имеет доступ для чтения файлов в этих директориях (Если вы ещё меняете путь виртуальных хостов DocumentRoot с /srv/http на другое расположение вам также нужно добавить сюда новые пути). При использовании путей по умолчанию, эта директива должна выглядеть так:

open_basedir = /srv/http/:/etc/webapps/:/usr/share/webapps/:/tmp/
25. Последнее что нужно, чтобы получить доступ к веб-интерфейсу phpMyAdmin, это добавить записи Apache на виртуальные хосты. В целях безопасности убедимся, что веб-интерфейс phpMyAdmin будет доступен только из локалхоста (или системного IP адреса) с использованием HTTPS протокола и не с других виртуальных хостов. Итак, откройте ваш файл Apache localhost-ssl.conf  и внизу, перед последней записью, добавьте следующее содержимое.

sudo vim /etc/httpd/conf/sites-enabled/localhost-ssl.conf
Alias /phpmyadmin "/usr/share/webapps/phpMyAdmin"

<Directory "/usr/share/webapps/phpMyAdmin">
    DirectoryIndex index.html index.php
    AllowOverride All
    Options FollowSymlinks
    Require all granted
</Directory>
26. После всего перезапустите демон Apache и перейдите в вашем браузере по следующему адресу, чтобы получить доступ к веб-интерфейсу вашего phpMyAdmin: https://localhost/phpmyadmin или https://system_IP/phpmyadmin.

27. Если после входа в phpMyAdmin, вы видите внизу сообщение об ошибке относящееся к blowfish_secret, то откройте и отредактируйте файл /etc/webapps/phpmyadmin/config.inc.php и вставьте случайную строку вроде следующей, затем перезагрузите страницу.

$cfg['blowfish_secret'] = 'kjLGJ8g;Hj3mlHy+Gd~FE3mN{gIATs^1lX+T=KVYv{ubK*U0V';
28. Включение дополнительных возможностей phpMyAdmin. Это необязательно, но для получения дополнительной функциональности и отсутствия предупреждений, добавьте в файл /etc/webapps/phpmyadmin/config.inc.php строку

$cfg['Servers'][$i]['pmadb'];
И импортируйте файл /usr/share/webapps/phpMyAdmin/sql/create_tables.sql.

Шаг 9: Включение LAMP при загрузке
29. Если вы хотите, чтобы стек LAMP загружался автоматически после перезагрузки системы, то выполните следующую команду.

sudo systemctl enable httpd mysqld
Здесь были описаны главные конфигурационные настройки LAMP, которые нужны для превращения вашей системы на Arch Linux в простую, но мощную и крепкую веб-платформу с самым последним серверным программным обеспечением для маленький некритичных окружений. Но для использования в рабочем окружении вам нужно продолжить изучение опций и особенностей обслуживания веб-серверов, уделять особое внимание обновлению пакетов и делать регулярное резервное копирование образов для быстрого восстановления системы в случае аварий.
```
