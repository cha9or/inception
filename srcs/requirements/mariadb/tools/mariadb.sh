#!/bin/bash

if [ ! -d "/var/lib/mysql/${MYSQL_DATABASE}" ]; then
    # init db
    mariadbd-safe --initialize --datadir=/var/lib/mysql --user=mysql --skip-test-db  >/dev/null 2>/dev/null
    # start db server
    mariadbd-safe --datadir=/var/lib/mysql --user=mysql &
    # wait for db to start
    mariadb-admin -u root ping --silent --wait=30 >/dev/null 2>/dev/null

    # create database
    echo "CREATE DATABASE IF NOT EXISTS \`${MYSQL_DATABASE}\`;" | mariadb -u root
    echo "CREATE USER IF NOT EXISTS \`${MYSQL_USER}\`@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';" | mariadb -u root
    echo "GRANT ALL PRIVILEGES ON \`${MYSQL_DATABASE}\`.* TO \`${MYSQL_USER}\`@'%';" | mariadb -u root
    echo "FLUSH PRIVILEGES;" | mariadb -u root

    # change root password
    mariadb-admin -u root password "${MYSQL_ROOT_PASSWORD}"

    #shutdown server
    mariadb-admin -u root -p "${MYSQL_ROOT_PASSWORD}" shutdown
    
fi

exec mariadb-safe  --datadir=/var/lib/mysql --user=mysql