FROM alpine:3.11

RUN apk add --no-cache \
    autoconf \
    automake \
    build-base \
    clang \
    clang-static \
    gettext-dev \
    gettext-static \
    git \
    libmaxminddb-dev \
    libressl-dev \
    linux-headers \
    ncurses-dev \
    ncurses-static \
    tzdata \
    geoip-dev

WORKDIR /var/lib/goaccess
ARG GOACCESS_VERSION=1.3
RUN wget https://tar.goaccess.io/goaccess-${GOACCESS_VERSION}.tar.gz && \
        tar -xzvf goaccess-1.3.tar.gz && \
        cd goaccess-1.3/ && \
        ./configure --enable-utf8 --enable-geoip=mmdb && \
        make && \
        make install

RUN apk add --no-cache apache2

COPY goaccess.conf /usr/local/etc/goaccess/goaccess.conf
COPY init.sh /bin/init.sh

EXPOSE 80 7890

CMD [ "init.sh" ]