#!/bin/sh

mysql_install_db

/etc/init.d/mysql start

if [ -d "/var/lib/mysql/$MYSQL_DATABASE"]
then
    echo "Database already exist"
else

mysql_secure_installation << _EOF_
Y
$MYSQL_ROOT_PASSWORD
$MYSQL_ROOT_PASSWORD
Y
n
Y
Y
_EOF_

echo "GRANT ALL ON *.* TO 'root'@'%' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD'; FLUSH PRIVILEGES;" | mysql -uroot

echo "CREATE DATABASE IF NOT EXISTS $MYSQL_DATABASE; GRANT ALL ON $MYSQL_DATABASE.* TO '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD'; FLUSH PRIVILEGES;" | mysql -uroot

fi

/etc/init.d/mysql stop

exec "$@"