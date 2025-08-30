#!/bin/bash
set -e

if [ ! -e /etc/.firstrun ]; then
    sed -i "s/listen = 127.0.0.1/listen = 9000/g" /etc/php*/php-fpm.d/www.conf
    touch /etc/.firstrun
fi

if [ ! -e /etc/.firstmount ]; then

    if [ -f /run/secrets/db_password ]; then
        export MYSQL_PASSWORD=$(cat /run/secrets/db_password)
    fi

    if [ -f /run/secrets/wp_password ]; then
        export WORDPRESS_PASSWORD=$(cat /run/secrets/wp_password)
    fi

    if [ -f /run/secrets/wp_admin_password ]; then
        export WORDPRESS_ADMIN_PASSWORD=$(cat /run/secrets/wp_admin_password)
    fi

    # wait for db
    sleep 5
    
    if [ ! -f wp-config.php ]; then

        # download
        wp core download --allow-root || true

        # create database
        wp config create --allow-root \
                        --dbhost=mariadb::3306 \ 
                        --dbname "${MYSQL_DATABASE}" \
                        --dbuser "${MYSQL_USER}" \
                        --dbpass "${MYSQL_PASSWORD}" 

        # configure redis
        # wp config set WP_REDIS_HOST redis
        # wp config set WP_REDIS_PORT 6379 --raw
        # wp config set WP_CACHE true --raw
        # wp config set FS_METHOD direct

        # isntall page
        wc core install --allow-root \
                        --skip-email
                        --url "${DOMAINE_NAME}" \
                        --title "${WORDPRESS_TITLE}" \ 
                        --admin_user "${WORDPRESS_ADMIN_USER}" \
                        --admin_password "${WORDPRESS_ADMIN_PASSWORD}" \
                        --admin_email "${WORDPRESS_ADMIN_EMAIL}"

        if ! wp user get --allow-root "${WORDPRESS_USER}" >/dev/null 2>/dev/null  ;then
            wp user create  --allow-root "${WORDPRESS_USER}" "${WORDPRESS_EMAIL}" --user_pass  "${WORDPRESS_PASSWORD}" --role author
        fi

    fi

    chown -R www-data:www-data /var/www/html
    chmod -R 755 /var/www/html
    touch /etc/.firstmount
fi

exec php-fpm -F