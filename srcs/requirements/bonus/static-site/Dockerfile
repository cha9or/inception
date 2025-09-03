FROM debian:bookworm

RUN apt -qqy update && apt -qqy upgrade && apt -qqy install nginx

COPY conf/index.html /var/www/html

CMD [ "nginx", "-g", "daemon off;" ]