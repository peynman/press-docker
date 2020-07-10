ARG ECHO_NODE_VERSION=12.18.1
FROM node:${ECHO_NODE_VERSION}-alpine

USER root

RUN apk add --update --no-cache bash
RUN yarn global add --prod --no-lockfile laravel-echo-server \
	&& yarn cache clean

WORKDIR /app

ARG ECHO_AUTH_PATH
ARG ECHO_PORT
ARG ECHO_PROTOCOL
ARG ECHO_SSL_CERTPATH
ARG ECHO_SSL_KEYPATH
ARG ECHO_SSL_CERTCHAINPATH
ARG ECHO_SSL_PASSPHRASE
ARG ECHO_REDIS_PASS
ARG ECHO_REDIS_DB
ARG ECHO_REDIS_PORT
ARG ECHO_REDIS_HOST
ARG ECHO_RUNTIME_MODE=
ARG ECHO_CLIENT_APP_ID=
ARG ECHO_CLIENT_APP_KEY=
ARG CONFIG=laravel-echo-server-${ECHO_RUNTIME_MODE}.json

COPY ./${CONFIG} /app/laravel-echo-server.json

ARG ECHO_AUTH_HOST=apache2
RUN sed -i "s~#ECHO_AUTH_HOST_PLACEHOLDER~${ECHO_AUTH_HOST}~g" /app/laravel-echo-server.json

RUN sed -i "s~#ECHO_AUTH_PATH_PLACEHOLDER~${ECHO_AUTH_PATH}~g" /app/laravel-echo-server.json
RUN sed -i "s~#ECHO_PORT_PLACEHOLDER~${ECHO_PORT}~g" /app/laravel-echo-server.json
RUN sed -i "s~#ECHO_PROTOCOL_PLACEHOLDER~${ECHO_PROTOCOL}~g" /app/laravel-echo-server.json
RUN sed -i "s~#ECHO_SSL_CERTPATH_PLACEHOLDER~${ECHO_SSL_CERTPATH}~g" /app/laravel-echo-server.json
RUN sed -i "s~#ECHO_SSL_KEYPATH_PLACEHOLDER~${ECHO_SSL_KEYPATH}~g" /app/laravel-echo-server.json
RUN sed -i "s~#ECHO_SSL_CERTCHAINPATH_PLACEHOLDER~${ECHO_SSL_CERTCHAINPATH}~g" /app/laravel-echo-server.json
RUN sed -i "s~#ECHO_SSL_PASSPHRASE_PLACEHOLDER~${ECHO_SSL_PASSPHRASE}~g" /app/laravel-echo-server.json
RUN sed -i "s~#REDIS_PORT_PLACEHOLDER~${ECHO_REDIS_PORT}~g" /app/laravel-echo-server.json
RUN sed -i "s~#REDIS_HOST_PLACEHOLDER~${ECHO_REDIS_HOST}~g" /app/laravel-echo-server.json
RUN sed -i "s~#REDIS_PASS_PLACEHOLDER~${ECHO_REDIS_PASS}~g" /app/laravel-echo-server.json
RUN sed -i "s~#REDIS_DB_PLACEHOLDER~${ECHO_REDIS_DB}~g" /app/laravel-echo-server.json
RUN sed -i "s~#ECHO_CLIENT_APP_ID_PLACEHOLDER~${ECHO_CLIENT_APP_ID}~g" /app/laravel-echo-server.json
RUN sed -i "s~#ECHO_CLIENT_APP_KEY_PLACEHOLDER~${ECHO_CLIENT_APP_KEY}~g" /app/laravel-echo-server.json

RUN echo '${ECHO_REDIS_HOST} ${ECHO_REDIS_PASS} ${ECHO_REDIS_DB}'
RUN laravel-echo-server init
RUN laravel-echo-server client:add

EXPOSE ${ECHO_PORT}
ENV DEBUG=*
CMD ["laravel-echo-server", "start"]
