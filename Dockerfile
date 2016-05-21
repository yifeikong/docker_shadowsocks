FROM alpine:3.2
MAINTAINER Yifei Kong <kong@yifei.me>

RUN apk add --update python py-pip && \
    pip install shadowsocks && \
    rm -rf /var/cache/apk/*

ADD shadowsocks.json /etc/shadowsocks.json

CMD ["ssserver", "-c", "/etc/shadowsocks.json"]
