ARG POSTGRES_VERSION=13.1-alpine

FROM postgres:${POSTGRES_VERSION}

COPY docker-entrypoint-initdb.d /docker-entrypoint-initdb.d
