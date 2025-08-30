FROM alpine:3.21

RUN apk update && apk add --no-cache nginx openssl bash

COPY conf/nginx.conf /etc/http.d/default.conf

COPY tools/nginx.sh /usr/local/bin/nginx.sh

RUN chmod +x /usr/local/bin/nginx.sh

ENTRYPOINT [ "nginx", "-g", "daemon off;"]