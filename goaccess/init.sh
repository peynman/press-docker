#!/bin/sh

goaccess -f /srv/logs/apache2/main-access.log -o /var/www/localhost/htdocs/main-access.html --log-format=COMBINED --ws-url=127.0.0.1:8084 --real-time-html &

/usr/sbin/httpd -DFOREGROUND