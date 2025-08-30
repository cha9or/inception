#!/bin/bash

if [ ! -d "/var/lib/mysql/${MYSQL_DATABASE}" ]; then
    # init db
    mysql_install_db --datadir=/var/lib/mysql --user=mysql --skip-test-db  >/dev/null 2>/dev/null
    # start db server
    mysqld_safe --datadir=/var/lib/mysql --user=mysql &
    # wait for db to start
    mysqladmin -u root ping --silent --wait=30 >/dev/null 2>/dev/null

    # create database
    echo "CREATE DATABASE IF NOT EXISTS \`${MYSQL_DATABASE}\`;" | mysql -u root
    echo "CREATE USER IF NOT EXISTS \`${MYSQL_USER}\`@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';" | mysql -u root
    echo "GRANT ALL PRIVILEGES ON \`${MYSQL_DATABASE}\`.* TO \`${MYSQL_USER}\`@'%';" | mysql -u root
    echo "FLUSH PRIVILEGES;" | mysql

    #shutdown server
    mysqladmin -u root shutdown
    
fi

exec mysqld_safe  --datadir=/var/lib/mysql --user=mysql