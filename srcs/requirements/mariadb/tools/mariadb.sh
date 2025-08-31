#!/bin/bash
set -e

if [ ! -d /etc/.firstrun ]; then

    if [ -f /run/secrets/db_root_password ]; then
        export MYSQL_ROOT_PASSWORD=$(cat /run/secrets/db_root_password)
    fi

    if [ -f /run/secrets/db_password ]; then
        export MYSQL_PASSWORD=$(cat /run/secrets/db_password)
    fi

    cat << EOF >> /etc/my.cnf.d/mariadb-server.cnf
[mysqld]
bind-address=0.0.0.0
skip-networking=0
EOF


    # init db
    mariadbd-safe --initialize --auth-root-authentication-method=socket  --datadir=/var/lib/mysql --user=mysql --skip-test-db 
    # start db server
    mariadbd-safe --datadir=/var/lib/mysql --user=mysql &
    # wait for db to start
    mariadb-admin -u root ping --silent --wait=15

    # create database
    mariadbd-safe  -u root -e "
    CREATE DATABASE IF NOT EXISTS \`${MYSQL_DATABASE}\`;
    CREATE USER IF NOT EXISTS \`${MYSQL_USER}\`@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';
    GRANT ALL PRIVILEGES ON \`${MYSQL_DATABASE}\`.* TO \`${MYSQL_USER}\`@'%';
    FLUSH PRIVILEGES;"

    # change root password
    mariadb-admin -u root password "${MYSQL_ROOT_PASSWORD}"

    #shutdown server
    mariadb-admin -u root -p"${MYSQL_ROOT_PASSWORD}" shutdown
    
    touch /etc/.firstrun
fi

exec mariadb-safe  --datadir=/var/lib/mysql --user=mysql