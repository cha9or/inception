FROM alpine:3.19
RUN apk add --no-cache bash curl git github-cli
COPY tools/bot.sh /usr/local/bin/bot.sh
RUN chmod +x /usr/local/bin/bot.sh
ENTRYPOINT ["/usr/local/bin/bot.sh"]
