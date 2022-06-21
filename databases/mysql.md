# create user
```
sudo mysql -u root mysql

CREATE USER 'user'@'localhost' IDENTIFIED BY 'user';
GRANT ALL PRIVILEGES ON *.* TO 'user'@localhost IDENTIFIED BY 'user';
FLUSH PRIVILEGES;

SELECT User, Host, plugin FROM mysql.user;
```

# Узнать размер базы
```sql
SELECT table_schema AS "database",
ROUND(SUM(data_length + index_length) / 1024 / 1024 / 1024, 2) AS "Размер в гб"
-- в мегабайтах ROUND(SUM(data_length + index_length) / 1024 / 1024, 2) AS "Размер в мб"
-- в килобайтах ROUND(SUM(data_length + index_length) / 1024 / 1024, 2) AS "Размер в кб"
FROM information_schema.TABLES
WHERE table_schema = " {{ DATABASE_NAME }} "
GROUP BY table_schema;
```

# create database
```
mysql -u user -p

create database dbname;
use dbname;
ALTER DATABASE dbname COLLATE utf8mb4_general_ci;
SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, AUTOCOMMIT = 0;
SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS = 0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS = 0;

source FILENAME.sql;

SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
SET AUTOCOMMIT = @OLD_AUTOCOMMIT;
COMMIT;
```

#   сброс пароля sql-root
```
sudo service mysql stop

sudo mkdir -p /var/run/mysqld
sudo chown mysql:mysql /var/run/mysqld

sudo /usr/sbin/mysqld --skip-grant-tables --skip-networking &
jobs

mysql -u root
FLUSH PRIVILEGES;
USE mysql;
UPDATE user SET authentication_string=PASSWORD("root") WHERE User='root';
UPDATE user SET plugin="mysql_native_password" WHERE User='root';
quit

sudo pkill mysqld
sudo service mysql start

mysql -u root -p
```

# mariadb 5.5
```
CREATE USER 'user' IDENTIFIED BY 'user';
GRANT ALL privileges ON `db_name`.* TO 'user'@localhost;
FLUSH PRIVILEGES;
SHOW GRANTS FOR 'user'@localhost;

SET PASSWORD FOR 'user'@'localhost' = PASSWORD('user');
```
