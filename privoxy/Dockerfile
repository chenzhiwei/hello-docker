FROM alpine

RUN apk add --no-cache privoxy \
    && sed -i 's/^listen-address[ \t]*.*$/listen-address  0.0.0.0:8118/g' /etc/privoxy/config

CMD ["privoxy", "--no-daemon", "--user", "privoxy", "/etc/privoxy/config"]
