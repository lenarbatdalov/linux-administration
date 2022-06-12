# Mariadb
```zsh
sudo apt install mariadb-server

sudo mysql -u root mysql

CREATE USER 'user'@'localhost' IDENTIFIED BY 'user';
GRANT ALL PRIVILEGES ON *.* TO 'user'@localhost IDENTIFIED BY 'user';
FLUSH PRIVILEGES;
\q
```
