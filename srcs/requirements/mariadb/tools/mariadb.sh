#!/bin/bash
set -e

if [ ! -d /etc/.firstrun ]; then
    # init db
    mariadbd-safe --initialize --datadir=/var/lib/mysql --user=mysql --skip-test-db  >/dev/null 2>/dev/null
    # start db server
    mariadbd-safe --datadir=/var/lib/mysql --user=mysql &
    # wait for db to start
    mariadb-admin -u root ping --silent --wait 30 >/dev/null 2>/dev/null

    # create database
    mariadb-safe -u root -e "
    CREATE DATABASE IF NOT EXISTS \`${MYSQL_DATABASE}\`;
    CREATE USER IF NOT EXISTS \`${MYSQL_USER}\`@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';
    GRANT ALL PRIVILEGES ON \`${MYSQL_DATABASE}\`.* TO \`${MYSQL_USER}\`@'%';
    FLUSH PRIVILEGES;"

    # change root password
    mariadb-admin -u root password "${MYSQL_ROOT_PASSWORD}"

    #shutdown server
    mariadb-admin -u root -p "${MYSQL_ROOT_PASSWORD}" shutdown
    
    touch /etc/.firstrun
fi

exec mariadb-safe  --datadir=/var/lib/mysql --user=mysql