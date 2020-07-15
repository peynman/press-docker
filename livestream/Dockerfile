ARG NGINX_VERSION=1.19.0
ARG NGINX_RTMP_VERSION=1.2.1
ARG FFMPEG_VERSION=4.1.3

##############################
# Build the NGINX-build image.
FROM alpine:3.8 as build-nginx
ARG NGINX_VERSION
ARG NGINX_RTMP_VERSION

# Build dependencies.
RUN apk add --update \
  build-base \
  ca-certificates \
  curl \
  gcc \
  libc-dev \
  libgcc \
  linux-headers \
  make \
  musl-dev \
  openssl \
  openssl-dev \
  pcre \
  pcre-dev \
  pkgconf \
  pkgconfig \
  zlib-dev

# Get nginx source.
RUN cd /tmp && \
  wget https://nginx.org/download/nginx-${NGINX_VERSION}.tar.gz && \
  tar zxf nginx-${NGINX_VERSION}.tar.gz && \
  rm nginx-${NGINX_VERSION}.tar.gz

# Get nginx-rtmp module.
RUN cd /tmp && \
  wget https://github.com/arut/nginx-rtmp-module/archive/v${NGINX_RTMP_VERSION}.tar.gz && \
  tar zxf v${NGINX_RTMP_VERSION}.tar.gz && rm v${NGINX_RTMP_VERSION}.tar.gz

# Compile nginx with nginx-rtmp module.
RUN cd /tmp/nginx-${NGINX_VERSION} && \
  ./configure \
  --prefix=/opt/nginx \
  --add-module=/tmp/nginx-rtmp-module-${NGINX_RTMP_VERSION} \
  --conf-path=/opt/nginx/nginx.conf \
  --with-threads \
  --with-file-aio \
  --with-http_ssl_module \
  --with-http_stub_status_module \
  --with-http_auth_request_module \
  --error-log-path=/opt/nginx/logs/error.log \
  --http-log-path=/opt/nginx/logs/access.log \
  --with-debug && \
  cd /tmp/nginx-${NGINX_VERSION} && make && make install

##########################
# Build the release image.
FROM alpine:3.8
LABEL MAINTAINER Alfred Gutierrez <alf.g.jr@gmail.com>

RUN apk add --update \
  ca-certificates \
  openssl \
  pcre \
  lame \
  libogg \
  libass \
  libvpx \
  libvorbis \
  libwebp \
  libtheora \
  opus \
  rtmpdump \
  x264-dev \
  x265-dev

COPY --from=build-nginx /opt/nginx /opt/nginx
COPY --from=build-ffmpeg /usr/local /usr/local
COPY --from=build-ffmpeg /usr/lib/libfdk-aac.so.2 /usr/lib/libfdk-aac.so.2

# Add NGINX config and static files.
ADD nginx.conf /opt/nginx/nginx.conf

ARG LIVESTREAM_AUTH_HOST=apache2
RUN sed -i "s~#LIVESTREAM_AUTH_HOST_PLACEHOLDER~$LIVESTREAM_AUTH_HOST~g" /opt/nginx/nginx.conf

RUN mkdir -p /opt/data && mkdir /www
ADD static /www/static

COPY .htpasswd /opt/nginx/.htpasswd

EXPOSE 1935
EXPOSE 80

CMD ["/opt/nginx/sbin/nginx"]
