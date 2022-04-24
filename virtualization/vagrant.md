отличная статья [https://tokmakov.msk.ru/blog/item/435]

# basic
```
	https://help.ubuntu.ru/wiki/vagrant

	sudo apt install vagrant
	vagrant -v

	Скачать бокс с Ubuntu 14.04
	vagrant box add ubuntu/trusty64

	Посмотреть список боксов
	vagrant box list

	инициализация
	vagrant init ubuntu/xenial64

	запуск
	vagrant up

	Подключение
	vagrant ssh

	Снова настроить машину
	Если изменишь файл конфигурации - выполни команду и Vagrant снова настроит машину
	vagrant provision

	Перезагрузка
	vagrant reload

	Остановка
	vagrant halt

	полностью все удалить
	vagrant destroy

	Если в хост-системе выполнить команду, то можно увидеть все ВМ и их состояние.
	vagrant global-status

	Если ВМ удалялась не через Vagrant, она может остаться в global-status. Лечится это так:
	vagrant global-status --prune

	Можно создать из виртуалки бокс, сказав в каталоге с Vagrantfile:
	vagrant package

	Импорт бокса:
	vagrant box add myubuntu package.box
	vagrant box list
	vagrant box remove myubuntu

	показывает список проброшенных портов
	vagrant port
```

# https://guides.hexlet.io/vagrant/
```
	файл Vagrantfile
	Vagrant.configure('2') do |config|
	  config.vm.box = 'ubuntu/xenial64'
	end

	Предположим, что внутри вагранта сайт стартует на порту 8080, и вы хотите обращаться к нему снаружи. Для этого достаточно добавить в конфигурацию:
	config.vm.network "forwarded_port", guest: 8080, host: 8080


	# имя в `vagrant global-status`
	config.vm.define "ubuntu1" do |t|
	end
	# имя в VirtualBox
	config.vm.provider "virtualbox" do |v|
		v.name = "ubuntu1"
	end


	Часто требуется присвоить виртуалке фиксированный IP в LAN. Для этого находим в Vagrantfile строку, похожую на следующую, раскомментируем и правим:
	config.vm.network "private_network", ip: "10.110.0.10"
	проверяем
	ping 10.110.0.10
```

# Синхронизация директорий
```
	По умолчанию синхронизируется директория, где расположен Vagrantfile на хост-системе с директорией /vagrant виртуальной машины. Это можно изменить с помощью настройки config.vm.synced_folder: указывается абсолютный или относительный путь для хост-системы и абсолютный — для виртуальной машины.

	d:/vagrant/www/site1.loc <=> /var/www/site1.loc
```

# Если команд много, их удобно объединить:
```
	$script = <<~SCRIPT
	  echo Installing Nginx
	  apt-get install -y nginx
	  echo Installing MySQL
	  apt-get install -y mysql-server
	  echo Installing PHP
	  apt-get install -y php-fpm php-mysql
	SCRIPT
	Vagrant.configure(2) do |config|
	  config.vm.box = "bento/ubuntu-18.04"
	  config.vm.provision "shell", inline: $script
	end

	$update = <<~UPDATE
	  apt-get update
	  apt-get -y upgrade
	UPDATE
	$install = <<~INSTALL
	  apt-get install -y nginx
	  apt-get install -y mysql-server
	  apt-get install -y php-fpm php-mysql
	INSTALL
	Vagrant.configure(2) do |config|
	  config.vm.box = "bento/ubuntu-18.04"
	  config.vm.provision "update", type: "shell", inline: $update
	  config.vm.provision "install", type: "shell", inline: $install
	end
```

# Или вообще вынести в отдельный shell-файл:
```
	Vagrant.configure(2) do |config|
	  config.vm.box = "bento/ubuntu-18.04"
	  config.vm.provision "shell", path: "provision.sh"
	end


	# provision.sh
	apt-get install -y nginx
	apt-get install -y mysql-server
	apt-get install -y php-fpm php-mysql
```

# Если у каждого поставщика есть имя, то можно выполнить только его:
```
	Vagrant.configure(2) do |config|
		config.vm.box = "bento/ubuntu-18.04"
		config.vm.provision "update", type: "shell", path: "update.sh"
		config.vm.provision "install", type: "shell", path: "install.sh"
	end

	vagrant provision --provision-with update
```

# mysql
```
	config.vm.provision "shell", inline: <<-QUERY
	    mysql -uroot -e "ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY 'qwerty'; FLUSH PRIVILEGES;"
	  QUERY
	  
	  
	echo "GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY 'rootpass' WITH GRANT OPTION; FLUSH PRIVILEGES;" | mysql -u root --password=rootpass
  #echo "GRANT PROXY ON ''@'' TO 'root'@'%' WITH GRANT OPTION" | mysql -u root --password=rootpass
  sudo service mysql restart

  # Create database for form responses (WebExampleBox)
  mysql -uroot -p'rootpass' -e "DROP DATABASE IF EXISTS formresponses; 
	  CREATE DATABASE formresponses; 
	  USE formresponses; 
	  CREATE TABLE response (id INT NOT NULL PRIMARY KEY AUTO_INCREMENT, 
		  firstname VARCHAR(20), lastname VARCHAR(20), 
		  email VARCHAR(50), submitdate DATETIME);"
  sudo service mysql restart
```

# plugins
```
	Самый важный из этих плагинов - vagrant-vbguest.
	https://github.com/dotless-de/vagrant-vbguest

	Без него возможна ситуация, когда обновив виртуальную машину вы увидите, что папка с кодом перестала синхронизироваться, и внутри вагранта её нет.


	В качестве примера альтернативного провайдера рассмотрим vagrant-lxc. Как вы догадались, он позволяет делать все, что было описано выше, используя LXC вместо VirtualBox. Если в двух словах:
	# ставим плагин
	vagrant plugin install vagrant-lxc
	# создаем и запускаем виртуалку
	vagrant init fgrehm/precise64-lxc
	vagrant up --provider=lxc
```

# example [provision.sh]
```
	apt-get update
	apt-get -y upgrade

	apt-get install -y nginx
	apt-get install -y mysql-server
	apt-get install -y php-fpm php-mysql

	# создаем две директории для двух виртуальных хостов
	mkdir /var/www/site1.loc
	mkdir /var/www/site2.loc
	# создаем в каждой из этих директорий php-файл
	echo '<?php phpinfo(); ?>' > /var/www/site1.loc/index.php
	echo '<?php phpinfo(); ?>' > /var/www/site2.loc/index.php

	# создаем два виртуальных хоста
	cat > /etc/nginx/sites-available/site1.loc <<EOF
	server {
	    # слушать порт 80
	    listen 80;
	    # директория сайта
	    root /var/www/site1.loc;
	    # индексные файлы
	    index index.php index.html;
	    # домен сайта
	    server_name site1.loc www.site1.loc;

	    location / {
	        try_files \$uri \$uri/ =404;
	    }

	    # PHP скрипты передаются на выполнение FastCGI серверу
	    location ~ \.php$ {
	        include snippets/fastcgi-php.conf;
	        # With php-fpm (or other unix sockets):
	        fastcgi_pass unix:/var/run/php/php7.2-fpm.sock;
	    }
	}
	EOF

	cat > /etc/nginx/sites-available/site2.loc <<EOF
	server {
	    # слушать порт 80
	    listen 80;
	    # директория сайта
	    root /var/www/site2.loc;
	    # индексные файлы
	    index index.php index.html;
	    # домен сайта
	    server_name site2.loc www.site2.loc;

	    location / {
	        try_files \$uri \$uri/ =404;
	    }

	    # PHP скрипты передаются на выполнение FastCGI серверу
	    location ~ \.php$ {
	        include snippets/fastcgi-php.conf;
	        # With php-fpm (or other unix sockets):
	        fastcgi_pass unix:/var/run/php/php7.2-fpm.sock;
	    }
	}
	EOF

	ln -s /etc/nginx/sites-available/site1.loc /etc/nginx/sites-enabled/
	ln -s /etc/nginx/sites-available/site2.loc /etc/nginx/sites-enabled/

	echo '' >> '/etc/hosts'
	echo '127.0.0.1   site1.loc www.site1.loc' >> '/etc/hosts'
	echo '127.0.0.1   site2.loc www.site2.loc' >> '/etc/hosts'

	systemctl reload nginx
```
