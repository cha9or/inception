FROM debian:bookworm

RUN apt -qqy update && apt -qqy upgrade && apt -qqy install openssl nginx

COPY conf/nginx.conf /etc/nginx/sites-available/default

COPY --chmod=755 tools/nginx.sh /usr/local/bin/

ENTRYPOINT [ "nginx.sh"]