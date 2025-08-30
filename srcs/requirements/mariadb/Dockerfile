FROM alpine:3.21

RUN apk update && apk add --no-cache mariadb mariadb-client bash

COPY conf/mariadb.cnf /etc/my.cnf.d/mariadb.cnf

COPY tools/init_db.sh /usr/local/bin/init_db.sh

RUN chmod +x /usr/local/bin/init_db.sh

ENTRYPOINT [ "mariadb.sh" ]