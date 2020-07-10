FROM quay.io/influxdb/influxdb:2.0.0-beta

COPY entrypoint.sh /usr/bin/entrypoint.sh

EXPOSE 9999

CMD [ "influxd" , "--reporting-disabled"]
