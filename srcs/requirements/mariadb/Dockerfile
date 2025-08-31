FROM alpine:3.21

RUN apk update && apk add --no-cache mariadb mariadb-client bash

COPY --chmod=755 tools/mariadb.sh /usr/local/bin/

ENTRYPOINT [ "mariadb.sh" ]