FROM httpd:2.4-alpine

RUN sed -i '/LoadModule rewrite_module/s/^#//g' /usr/local/apache2/conf/httpd.conf
RUN sed -i '/LoadModule proxy_module/s/^#//g' /usr/local/apache2/conf/httpd.conf
RUN sed -i '/LoadModule deflate_module/s/^#//g' /usr/local/apache2/conf/httpd.conf
RUN sed -i '/LoadModule proxy_fcgi_module/s/^#//g' /usr/local/apache2/conf/httpd.conf
RUN sed -i '/LoadModule headers/s/^#//g' /usr/local/apache2/conf/httpd.conf
RUN sed -i '/LoadModule actions/s/^#//g' /usr/local/apache2/conf/httpd.conf
RUN sed -i '/LoadModule info_module/s/^#//g' /usr/local/apache2/conf/httpd.conf
RUN sed -i '/#Include conf\/extra\/httpd-vhosts.conf/s/^#//g' /usr/local/apache2/conf/httpd.conf

ARG APACHE_RUNTIME_MODE=debug
ARG APACHE_RUNTIME_VHOST_PATH=vhosts/laravel
COPY  ${APACHE_RUNTIME_VHOST_PATH}/httpd-vhosts-${APACHE_RUNTIME_MODE}.conf /usr/local/apache2/conf/extra/httpd-vhosts.conf

WORKDIR /var/www/

EXPOSE 80 443
