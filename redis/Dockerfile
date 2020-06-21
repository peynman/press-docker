ARG REDIS_VERSION=5

FROM redis:${REDIS_VERSION}-alpine

ARG REDIS_RUNTIME_MODE=debug
COPY redis-${REDIS_RUNTIME_MODE}.conf /var/redis/redis.conf

ARG REDIS_PASSWORD=redis
ARG REDIS_BIND=127.0.0.1
ARG REDIS_LOGFILE=/var/log/redis/redis.log

RUN sed -i "s~#PASSWORD_PLACEHOLDER~ requirepass ${REDIS_PASSWORD}~g" /var/redis/redis.conf
RUN sed -i "s~#BIND_PLACEHOLDER~bind ${REDIS_BIND}~g" /var/redis/redis.conf
RUN sed -i "s~#LOGFILE_PLACEHOLDER~ logfile \"${REDIS_LOGFILE}\"~g" /var/redis/redis.conf

RUN cat /var/redis/redis.conf | grep 'logfile'

EXPOSE 6379

CMD [ "redis-server", "/var/redis/redis.conf"]
