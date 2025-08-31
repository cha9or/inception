#!/bin/bash
set -e

if [ ! -e /etc/.firstrun ]; then
    sed -i 's|listen = .*|listen = 9000|' /etc/php/8.2/fpm/pool.d/www.conf
    touch /etc/.firstrun
fi

if [ ! -e /etc/.firstmount ]; then

    [ -f /run/secrets/db_password ] && export MYSQL_PASSWORD=$(cat /run/secrets/db_password)
    [ -f /run/secrets/wp_password ] && export WORDPRESS_PASSWORD=$(cat /run/secrets/wp_password)
    [ -f /run/secrets/wp_admin_password ] && export WORDPRESS_ADMIN_PASSWORD=$(cat /run/secrets/wp_admin_password)

    chown -R www-data:www-data /var/www/html
    chmod -R 755 /var/www/html

    if [ ! -f /var/www/html/wp-config.php ]; then

        # download
        [ ! -d "/var/www/html/wp-content" ] && wp core download --allow-root || true

        wp config create --allow-root \
            --dbhost=mariadb \
            --dbuser="$MYSQL_USER" \
            --dbpass="$MYSQL_PASSWORD" \
            --dbname="$MYSQL_DATABASE"
 
        wp core install --allow-root \
            --skip-email \
            --url="$DOMAIN_NAME" \
            --title="$WORDPRESS_TITLE" \
            --admin_user="$WORDPRESS_ADMIN_USER" \
            --admin_password="$WORDPRESS_ADMIN_PASSWORD" \
            --admin_email="$WORDPRESS_ADMIN_EMAIL"

        wp user create --allow-root \
            "$WORDPRESS_USER" "$WORDPRESS_EMAIL" \
            --user_pass="$WORDPRESS_PASSWORD" \
            --role=author
    fi

    touch /etc/.firstmount
fi

exec php-fpm8.2 -F