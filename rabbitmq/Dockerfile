ARG RABBITMQ_VERSION=3.8.2
FROM rabbitmq:${RABBITMQ_VERSION}-alpine

RUN rabbitmq-plugins enable --offline rabbitmq_management
RUN rabbitmq-plugins enable rabbitmq_web_stomp

ADD init.sh /init.sh
RUN chmod +x /init.sh

CMD ["/init.sh"]