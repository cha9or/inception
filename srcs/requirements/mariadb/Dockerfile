FROM alpine:3.21

RUN apk update && apk add --no-cache mariadb mariadb-client bash

COPY conf/mariadb.cnf /etc/my.cnf.d/mariadb.cnf

COPY tools/mariadb.sh /usr/local/bin/mariadb.sh

RUN chmod +x /usr/local/bin/mariadb.sh

ENTRYPOINT [ "mariadb.sh" ]