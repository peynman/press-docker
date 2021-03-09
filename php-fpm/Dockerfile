ARG PHP_VERISON=7.4

FROM php:${PHP_VERISON}-fpm-alpine

## always clear cache or alpine apk update may fail
RUN rm -rf /var/cache/apk/* && \
    rm -rf /tmp/*

RUN apk update
RUN apk add --no-cache $PHPIZE_DEPS

ARG PHP_BASH=false
RUN if [ ${PHP_BASH} = true ]; then \
    apk add --no-cache bash bash-doc bash-completion \
;fi

ARG PHP_INSTALL_GD=false
RUN if [ ${PHP_INSTALL_GD} = true ]; then \
    apk add --no-cache  \
            freetype libpng libjpeg-turbo \
            freetype-dev \
            libjpeg-turbo-dev \
            libpng-dev \
        && docker-php-ext-configure gd --with-freetype --with-jpeg \
        ## GD png support is built in according to https://github.com/docker-library/php/issues/912
        && docker-php-ext-install -j$(nproc) gd \
;fi

ARG PHP_INSTALL_REDIS=false
RUN if [ ${PHP_INSTALL_REDIS} = true ]; then \
    pecl install redis \
    &&  docker-php-ext-enable redis \
;fi

ARG PHP_INSTALL_MYSQL=false
RUN if [ ${PHP_INSTALL_MYSQL} = true ]; then \
    docker-php-ext-install mysqli pdo pdo_mysql \
;fi

ARG PHP_INSTALL_INTL=false
RUN if [ ${PHP_INSTALL_INTL} = true ]; then \
    apk add --no-cache icu-dev && \
    docker-php-ext-configure intl && docker-php-ext-install intl\
;fi

ARG PHP_INSTALL_COMPOSER=false
ARG PHP_INSTALL_COMPOSER_VERSION=1
RUN if [ ${PHP_INSTALL_COMPOSER} = true ]; then \
    curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin --filename=composer --${PHP_INSTALL_COMPOSER_VERSION} \
;fi

ARG PHP_INSTALL_BCMATH=false
RUN if [ ${PHP_INSTALL_BCMATH} = true ]; then \
    docker-php-ext-install bcmath \
;fi

ARG PHP_INSTALL_PCNTL=false
RUN if [ ${PHP_INSTALL_PCNTL} = true ]; then \
    docker-php-ext-install pcntl \
;fi

ARG PHP_INSTALL_ZIP=false
RUN if [ ${PHP_INSTALL_ZIP} = true ]; then \
    apk add --no-cache zip libzip-dev && \
    docker-php-ext-install zip \
;fi

ARG PHP_INSTALL_SOAP=false
RUN if [ ${PHP_INSTALL_SOAP} = true ]; then \
    apk add --no-cache libxml2-dev && \
    docker-php-ext-install soap\
;fi

ARG PHP_INSTALL_SOCKETS=false
RUN if [ ${PHP_INSTALL_SOCKETS} = true ]; then \
    apk add --no-cache libxml2-dev &&\
    docker-php-ext-install sockets &&\
    docker-php-ext-enable sockets \
;fi

ARG PHP_INSTALL_GIT=false
RUN if [ ${PHP_INSTALL_GIT} = true ]; then \
    apk add --no-cache git \
;fi

ARG PHP_INSTALL_AMQLIB=false
RUN if [ ${PHP_INSTALL_AMQLIB} = true ]; then \
    apk add --no-cache rabbitmq-c-dev && \
    pecl install http://pecl.php.net/get/amqp-1.10.2.tgz && \
    rm -rf /tmp/pear && \
    docker-php-ext-enable amqp \
;fi

ARG PHP_INSTALL_XDEBUG=false
RUN if [ ${PHP_INSTALL_XDEBUG} = true ]; then \
    pecl install -f xdebug-3.0.3 && docker-php-ext-enable xdebug \
;fi

ARG PHP_TIMEZONE=UTC
ENV TIMEZONE=${PHP_TIMEZONE}

## copy config files
ARG PHP_FPM_RUNTIME_MODE=production
COPY php-init-${PHP_FPM_RUNTIME_MODE}.ini /usr/local/etc/php/conf.d/50-setting.ini
COPY php-fpm-${PHP_FPM_RUNTIME_MODE}.conf /usr/local/etc/php-fpm.d/www.conf

WORKDIR /var/www/
