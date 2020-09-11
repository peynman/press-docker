ARG MARIADB_VERSION=10.4

FROM mariadb:${MARIADB_VERSION}

RUN apt-get update
RUN apt-get install -y gettext-base

ARG MARIADB_RUNTIME_MODE=debug
COPY mariadb-${MARIADB_RUNTIME_MODE}.cnf /etc/mysql/conf.d/my.cnf
RUN chmod 644 -R /etc/mysql/conf.d/my.cnf

COPY docker-entrypoint-initdb.d /docker-entrypoint-initdb.d
RUN chmod 777 -R /docker-entrypoint-initdb.d

EXPOSE 3306
