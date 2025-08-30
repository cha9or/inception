FROM alpine:3.21

WORKDIR /var/www/html

RUN apk update && apk add --no-cache php php-fpm php-mysqli php-json php-curl \
                                     php-gd php-intl php-mbstring php-xml php-zip \
                                     bash

ADD https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar /usr/local/bin/wp

RUN chmod +x /usr/local/bin/wp

COPY tools/wordpress.sh /usr/local/bin/wordpress.sh

RUN chmod +x /usr/local/bin/wordpress.sh

ENTRYPOINT [ "wordpress.sh" ]