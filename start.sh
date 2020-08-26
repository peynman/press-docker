#!/usr/bin/env bash

docker container stop $(docker container ls -aq)

docker-compose -f ./docker-compose.yml --project-director=./ up -d \
    apache2 redis mariadb php-fpm \
    influxdb livestream telegraf \
    laravel-echo \
    traefik
#    revslider-apache2 revslider-php-fpm \
#    laravel-scheduler
