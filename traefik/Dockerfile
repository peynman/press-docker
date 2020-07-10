ARG TRAEFIK_VERSION=2.2.1
FROM traefik:${TRAEFIK_VERSION}

## include mysql client so we can connect to mysql
## and collect domains from db for TLS generation
RUN apk update
RUN apk add --no-cache mysql-client

COPY traefik.yml /etc/traefik/traefik.yml

ARG TRAEFIK_ENABLE_DASHBOARD=true
ARG TRAEFIK_INFLUXDB_URL=influxdb:9999
ARG TRAEFIK_INFLUXDB_DB=traefik
ARG TRAEFIK_INFLUXDB_USER=
ARG TRAEFIK_INFLUXDB_PASS=
ARG TRAEFIK_ACME_URL=
ARG TRAEFIK_DEBUG_MODE=true
ARG TRAEFIK_LOG_LEVEL=debug
ARG TRAEFIK_DEV_CERT_KEY=
ARG TRAEFIK_DEV_CERT_FILE=

RUN sed -i "s~#TRAEFIK_ENABLE_DASHBOARD_PLACEHOLDER~$TRAEFIK_ENABLE_DASHBOARD~g" /etc/traefik/traefik.yml
RUN sed -i "s~#TRAEFIK_INFLUXDB_URL_PLACEHOLDER~$TRAEFIK_INFLUXDB_URL~g" /etc/traefik/traefik.yml
RUN sed -i "s~#TRAEFIK_INFLUXDB_DB_PLACEHOLDER~$TRAEFIK_INFLUXDB_DB~g" /etc/traefik/traefik.yml
RUN sed -i "s~#TRAEFIK_INFLUXDB_USER_PLACEHOLDER~$TRAEFIK_INFLUXDB_USER~g" /etc/traefik/traefik.yml
RUN sed -i "s~#TRAEFIK_INFLUXDB_PASS_PLACEHOLDER~$TRAEFIK_INFLUXDB_PASS~g" /etc/traefik/traefik.yml
RUN sed -i "s~#TRAEFIK_ACME_URL_PLACEHOLDER~$TRAEFIK_ACME_URL~g" /etc/traefik/traefik.yml
RUN sed -i "s~#TRAEFIK_DEBUG_MODE_PLACEHOLDER~$TRAEFIK_DEBUG_MODE~g" /etc/traefik/traefik.yml
RUN sed -i "s~#TRAEFIK_LOG_LEVEL_PLACEHOLDER~$TRAEFIK_LOG_LEVEL~g" /etc/traefik/traefik.yml
RUN sed -i "s~#TRAEFIK_LOG_LEVEL_PLACEHOLDER~$TRAEFIK_LOG_LEVEL~g" /etc/traefik/traefik.yml
RUN sed -i "s~#TRAEFIK_DEV_CERT_KEY_PLACEHOLDER~$TRAEFIK_DEV_CERT_KEY~g" /etc/traefik/traefik.yml
RUN sed -i "s~#TRAEFIK_DEV_CERT_FILE_PLACEHOLDER~$TRAEFIK_DEV_CERT_FILE~g" /etc/traefik/traefik.yml


EXPOSE 8080 80 443
