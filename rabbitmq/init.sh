#!/bin/sh

# Create Rabbitmq user
( sleep 15 ; \

rabbitmqctl delete_user guest ; \
rabbitmqctl set_policy TTL ".*" '{"message-ttl":5000}' --apply-to queues ; \
rabbitmqctl add_user $RABBITMQ_ROOT_USER $RABBITMQ_ROOT_PASS ; \
rabbitmqctl set_user_tags $RABBITMQ_ROOT_USER administrator ; \
rabbitmqctl set_permissions -p / $RABBITMQ_ROOT_USER ".*" ".*" ".*" ; ) &

# $@ is used to pass arguments to the rabbitmq-server command.
# For example if you use it like this: docker run -d rabbitmq arg1 arg2,
# it will be as you run in the container rabbitmq-server arg1 arg2
rabbitmq-server $@