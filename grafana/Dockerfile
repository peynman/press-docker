ARG GRAFANA_VERSION=latest
FROM grafana/grafana:${GRAFANA_VERSION}

ARG GRAFANA_ADMIN_USER=admin
ARG GRAFANA_ADMIN_PASS=admin
ARG GRAFANA_ADMIN_URL=/

USER root
RUN sed -i "s~admin_user = admin~admin_user = ${GRAFANA_ADMIN_USER}~g" conf/defaults.ini
RUN sed -i "s~admin_password = admin~admin_password = ${GRAFANA_ADMIN_PASS}~g" conf/defaults.ini
RUN sed -i "s~root_url.*$~root_url = %(protocol)s://%(domain)s:%(http_port)s/grafana~g" conf/defaults.ini
RUN sed -i "s~serve_from_sub_path.*$~serve_from_sub_path = true~g" conf/defaults.ini

EXPOSE 3000
