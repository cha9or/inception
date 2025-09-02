FROM debian:bookworm

RUN apt -qqy update && apt -qqy upgrade && apt -qqy install adminer

ENTRYPOINT [ "php", "-S", "[::]8080", "-t", "/usr/share/adminer/adminer/" ]