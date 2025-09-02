FROM debian:bookworm

RUN apt -qqy update && apt -qqy upgrade

RUN mkdir /var/www/html/adminer/

ADD https://www.adminer.org/latest.php /var/www/html/adminer/adminer.php

ENTRYPOINT [ "php", "-S", "[::]:8080", "-t", "/var/www/html/adminer/" ]