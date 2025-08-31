FROM alpine:3.21

RUN apk update && apk add --no-cache nginx openssl bash

RUN mkdir -p /etc/nginx/ssl

COPY --chmod=755 tools/nginx.sh /usr/local/bin/

ENTRYPOINT [ "nginx.sh"]