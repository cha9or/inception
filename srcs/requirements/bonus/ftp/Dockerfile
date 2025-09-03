FROM debian:bookworm

RUN apt -qqy update && apt -qqy upgrade && apt -qqy install vsftpd

COPY --chmod=755 tools/ftp.sh /usr/local/bin/

COPY conf/ftp.conf /etc/vsftpd.conf

ENTRYPOINT [ "ftp.sh" ]