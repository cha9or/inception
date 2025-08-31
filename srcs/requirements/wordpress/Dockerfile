FROM alpine:3.21

WORKDIR /var/www/html

RUN apk update && apk add --no-cache php php-fpm php-mysqli php-phar bash

ADD --chmod=755 https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar /usr/local/bin/wp

COPY --chmod=755 tools/wordpress.sh /usr/local/bin/

ENTRYPOINT [ "wordpress.sh" ]