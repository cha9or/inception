FROM debian:bookworm

RUN apt -qqy update && apt -qqy upgrade && apt -qqy install php php-mysql

RUN mkdir /var/adminer/

ADD https://www.adminer.org/latest.php /var/adminer/index.php

WORKDIR /var/adminer/

ENTRYPOINT [ "php", "-S", "0.0.0.0:8080" ]