Управление контейнерами с LXD
- https://habr.com/ru/company/selectel/blog/308208/

# Установка lxd
```
#https://linuxcontainers.org/ru/lxd/getting-started-cli/
sudo snap install lxd

#https://linuxcontainers.org/ru/lxc/security/#_3
echo "1000:$(id -u):1" | sudo sh -c 'cat >> /etc/subuid'
echo "root:$(id -u):1" | sudo sh -c 'cat >> /etc/subuid'
id -u
//1000

echo "1000:$(id -g):1" | sudo sh -c 'cat >> /etc/subgid'
echo "root:$(id -g):1" | sudo sh -c 'cat >> /etc/subgid'

sudo usermod -aG lxd $(whoami)
sg lxd
lxd init
enter -> enter -> enter -> dir -> все остальное 'enter'
```

# Создание базового образа
```
lxc launch ubuntu:18.04 base
lxc exec base -- sudo --login

#меняю имя с ubuntu на lenar
usermod -l lenar -m -d /home/lenar ubuntu
groupmod -n lenar ubuntu
exit

lxc exec base -- sudo --login
#задаю одноименный пароль пользователя
passwd lenar

#файлу добавляю права на запись, чтобы отредактировать
chmod o=rw /etc/sudoers.d/90-cloud-init-users
vim /etc/sudoers.d/90-cloud-init-users
lenar ALL=(ALL) NOPASSWD:ALL
#возвращаю права
chmod o=r /etc/sudoers.d/90-cloud-init-users
exit

#захожу под пользователем
lxc exec base -- sudo --login --user lenar
```

### настройка ssh
```
#меняю настройки ssh в контейнере
vim /etc/ssh/sshd_config
PasswordAuthentication yes
sudo service ssh restart
```

### настройки локали
```
#https://wiki.debian.org/Locale
#в контейнере меняю файл
vim /etc/default/locale
LANG=ru_RU.UTF-8
LC_CTYPE="C.UTF-8"
LC_NUMERIC=en_US.UTF-8
LC_TIME=ru_RU.UTF-8
LC_COLLATE="C.UTF-8"
LC_MONETARY=ru_RU.UTF-8
LC_MESSAGES="en_US.UTF-8"
LC_PAPER=ru_RU.UTF-8
LC_NAME=ru_RU.UTF-8
LC_ADDRESS=ru_RU.UTF-8
LC_TELEPHONE=ru_RU.UTF-8
LC_MEASUREMENT=ru_RU.UTF-8
LC_IDENTIFICATION=ru_RU.UTF-8

#применяю локали
sudo locale-gen en_US.UTF-8 ru_RU.UTF-8
sudo timedatectl set-timezone Europe/Moscow
sudo service rsyslog restart
```

### установка базовых программ
```
sudo apt update
sudo apt install -y python3-pip
sudo apt install -y mc
sudo apt install -y git
exit
```

# Создаю из контейнера образ
```
#создаю из контейнера образ и экспортирую образ в архив
lxc stop base
lxc publish base --alias base-image
lxc image export base-image base-image
```

# Создаю образ проекта
```
#создаю контейнер проекта из базового образа и захожу в него
lxc launch base-image project
lxc exec project -- sudo --login --uxer lenar
```

### PostgreSQL
```
#https://www.postgresql.org/download/linux/ubuntu/
#устанавливаю в контейнере postgresql
sudo sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list'
wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -
sudo apt-get update
sudo apt-get -y install postgresql

#убираю пароль в pgsql для пользователя postgres
vim /etc/postgresql/12/main/pg_hba.conf

эти строки
local  all    postgres    peer
меняю на
local  all    postgres                 trust
host   all    postgres  127.0.0.1/32   trust

#применяю и проверяю
sudo service postgresql reload
psql -U postgres
psql -U postgres -h localhost
```

### Nginx, NodeJS
```
sudo apt install -y nginx

#https://github.com/nodesource/distributions/blob/master/README.md#installation-instructions
curl -sL https://deb.nodesource.com/setup_15.x | sudo -E bash -
sudo apt-get install -y nodejs
```

### Golang
```
#https://golang.org/doc/install
cd /usr/local
sudo wget https://golang.org/dl/go1.15.6.linux-amd64.tar.gz
sudo tar xf go1.15.6.linux-amd64.tar.gz
sudo rm go1.15.6.linux-amd64.tar.gz
sudo ln -s /usr/local/go/bin/go /usr/local/bin/go
sudo ln -s /usr/local/go/bin/godoc /usr/local/bin/godoc
sudo ln -s /usr/local/go/bin/gofmt /usr/local/bin/gofmt
sudo mkdir /usr/local/golib
sudo chown $(id -un):$(id -gn) /usr/local/golib

#добавляю переменные для golang
vim ~/.bashrc
export GOPATH=/usr/local/golib

#применяю настройки и устанавливаю пакеты go
. -/.bashrc
sudo apt install -y pkg-config libzmq3-dev
go get github.com/lib/pq
go get github.com/pebbe/zmq4
go get github.com/pquerna/ffjson
go get github.com/xeipuuv/gojsonschema
go get github.com/golang/protobuf/protoc-gen-go
```

### Python модули
```
sudo pip3 install asyncpg
pyzmq ujson jsonschema protobuf aiofiles
invoke fabri promt_toolkit pyinstaller
```

# Создаю образ из контейнера и экспортирую
```
# выхожу из контейнера и останавливаю его
exit
lxc stop project

#публикую и экспортирую
lsc publish project --alias project-image
lxc image export project-image project-image
```

# Заключение
```
Созданные архивы с образами - бэкап окружения.
Архивы можно использовать для распространения образов.
Для импорта образа из архива выполняю:
lxc image import project-image.tar.gz --alias project-image
```


# Основа
```
Контейнеры - это легкий механизм виртуализации, который не требует настройки виртуальной машины на эмуляции физического оборудования. В Linux, что они имеют в общем , является функция ядра , используемая: cgroups, namespaces(ipc, network, user, pid, mount). Они также пытаются создать более безопасные среды путем создания непривилегированных контейнеров и интеграции с такими функциями безопасности, как selinux. Эти технологии экспортируют API для лучшей интеграции с другими программами.
```

# LXD и LXC
```
Эти два объединяют одну семью, где:

 - lxc : пользовательский интерфейс для функций локализации ядра Linux. Это парень, который управляет пространствами имен Kernel, профилями Apparmor и SELinux, Chroots, возможностями Kernel и прочими связанными с ядром вещами.

 - lxd : контейнер "гипервизор". Он состоит из демона (lxd), интерфейса командной строки (lxc) и плагина OpenStack. Этот парень был разработан для обеспечения большей гибкости и функциональности для lxc, хотя он все еще использует его под капотом.

По сути, автономное пользовательское пространство ОС создается с изолированной инфраструктурой. lxc более непосредственно лежит в основе функций ОС для работы в сети и хранения данных, чем Docker.

Вы создаете много виртуальных машин, у которых есть пользовательское пространство и изоляция ядра, но они не являются полными виртуальными машинами, так как они не работают с разделенными ядрами, и не паравиртуализируются по той же причине.

Canonical является главным спонсором здесь, и Oracle также инвестирует трудозатраты на эту технологию.
```

# Docker
```
Он имеет некоторые отличия, являясь самым крупным из них движком, который оборачивает приложения автономной файловой системой вместо базового «образа пользовательского пространства». Идея состоит в том, чтобы содержать приложение и базовое изображение, чтобы создать впечатление, что приложение представляет собой единый процесс внутри движка. Docker использовал технологию lxc в качестве базового для связи с ядром, но сегодня он использует свою собственную библиотеку libcontainer.

Файловая система является абстракцией Docker, в то время как lxc напрямую использует функции файловой системы. Сеть также является абстракцией, в то время как с помощью lxc вы можете легко настроить IP-адреса и конфигурации маршрутизации. Некоторые сайты, похожие на App Store, поддерживаются Microsoft, Amazon, Vmware, IBM и другими игроками.

Докер. INC. Является основным спонсором здесь. Vmware также инвестирует в эту технологию.
```

# другие контейнерные технологии, которые есть в Linux: OpenVZ и Linux-VServer

# Дополнительно
```
Docker, Podman, Kubernetes — 1 контейнер = 1 stateless сервис. К тому же, из-за отсутствия состояния (в идеале), оно также воспроизводимо.
Docker (и аналог Podman) — это технология для «контейнеризации» приложений, т. е. для того, чтобы приложения носили за собой свой рантайм. Можно считать, что один Docker-контейнер == один процесс (технически их может быть больше, но обращаться с ними нужно именно так). Docker-контейнеры не являются долгоживущими и в норме вообще не хранят никакое состояние, т. е. их rootfs умирает вместе с контейнером. Предполагается, что все ценные/долгоживующие данные нужно монтировать внутрь контейнера bind’ами.

LXD — полная система и stateful.
А LXD — это контейнеры-виртуалки (играют ту же роль, что виртуалки). Они по умолчанию долгоживущие, внутри них запускается свой init и т. п. Аналогом этой технологии является systemd-nspawn.
```

