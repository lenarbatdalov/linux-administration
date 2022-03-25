https://wiki.manjaro.org/index.php?title=%D0%9E%D0%B1%D0%B7%D0%BE%D1%80_Pacman

Изучение опций Pacman
man pacman

Для обновления своей системы нужно ввести следующую команду в терминале: 
sudo pacman -Syu

Для синхронизации своей базы данных с репозиторием Manjaro введите в терминале следующую команду:
sudo pacman -Syy

Для одновременой синхронизации с репозиториями и обновления своей системы, введите:
sudo pacman -Syyu

Для поиска нужного приложения в репозиториях пакетов Manjaro необходимо знать его название. Префикс sudo для этого не требуется.
pacman -Ss [НАЗВАНИЕ ПАКЕТА]    (pacman -Ss leafpad)

Также возможен поиск пакета, который уже установлен в системе.
pacman -Qs [НАЗВАНИЕ ПАКЕТА]
В тоже время, чтобы получить более развернутую информацию об установленном пакете, нужно ввести команду:
pacman -Qi [НАЗВАНИЕ ПАКЕТА]
Наконец, можно получить исчерпывающую информацию о пакете, включая связанные файлы и данные, изменные пакетом, введя команду:
pacman -Qii [НАЗВАНИЕ ПАКЕТА]
В итоге, можно вывести полный список всех установленных в системе пакетов командой:
pacman -Ql

Сироты - установленные пакеты, которые больше не используются как чьи-то зависимости и не предназначены для какой-либо цели. (pacman -Qdt)
Настоятельно рекомендовано удалять все пакеты-сироты из системы.
Не смотря на то, что они с виду безвредны, тем не менее они не служат никакой цели и кроме того занимают место и ресурсы.
Вместо того, чтобы удалять их поодиночке, введите указанную выше команду чтобы очистить от них систему одним махом.
sudo pacman -Rs $(pacman -Qdtq)

Чтобы установить пакет приложений, следует выполнить: 
sudo pacman -S [НАЗВАНИЕ ПАКЕТА]

Чтобы установить пакеты уже загруженные в систему (название файла должно заканчиваться на pkg.tar.xz), используйте следующий синтаксис: 
sudo pacman -U [/путь к пакету/][название пакета.pkg.tar.xz]
Пример: sudo pacman -U ~/Загрузки/[leafpad.pkg.tar.xz]
Для установки пакета через адрес в интернете
pacman -U http://www.examplepackage/repo/examplepkg.tar.xz

Для удаления пакетов приложений достаточно ввести:
sudo pacman -R [НАЗВАНИЕ ПАКЕТА]
Можно также удалить сам пакет вместе с относящимеся к нему зависимостями, если эти зависимости не затрагивают другие нужные пакеты.
sudo pacman -Rs [НАЗВАНИЕ ПАКЕТА]

Для очистки кэша от уже установленных пакетов введите:
sudo pacman -Sc



Запрет пакетам на обновление
Настройки Pacman находятся в /etc/pacman.conf
Фиксирование версии пакета с запретом на обновление
IgnorePkg=package-name
Для нескольких пакетов нужно указать их названия через пробел в одну строку, либо для каждого вводить с новой строки IgnorePkg= .
Запрет на обновление доступен и для групп пакетов
IgnoreGroup=gnome



Arch - AUR (Arch User Repository)
https://wiki.manjaro.org/index.php?title=%D0%94%D0%BE%D1%81%D1%82%D1%83%D0%BF_%D0%BA_%D1%80%D0%B5%D0%BF%D0%BE%D0%B7%D0%B8%D1%82%D0%BE%D1%80%D0%B8%D1%8E_%D0%BF%D0%BE%D0%BB%D1%8C%D0%B7%D0%BE%D0%B2%D0%B0%D1%82%D0%B5%D0%BB%D0%B5%D0%B9_(AUR)
Чтобы установить пакет из AUR используя обертку для pacman типа yaourt, нужно выполнить:
yaourt -S [НАЗВАНИЕ ПАКЕТА]



# Parachute
https://github.com/tcorreabr/Parachute.git
kpackagetool5 --type KWin/Script --install ./Parachute || kpackagetool5 --type KWin/Script --upgrade ./Parachute
mkdir -p ~/.local/share/kservices5
ln -s ~/.local/share/kwin/scripts/Parachute/metadata.desktop ~/.local/share/kservices5/Parachute.desktop
kwriteconfig5 --file ~/.config/kwinrc --group ModifierOnlyShortcuts --key Meta "org.kde.kglobalaccel,/component/kwin,org.kde.kglobalaccel.Component,invokeShortcut,Parachute"
qdbus-qt5 org.kde.KWin /KWin reconfigure
