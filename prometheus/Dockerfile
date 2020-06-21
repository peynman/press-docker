FROM golang:1.13-alpine

ENV GO15VENDOREXPERIMENT=1

RUN apk add --no-cache git make bash yarn curl

RUN mkdir -p $GOPATH/src/github.com/prometheus && \
        cd $GOPATH/src/github.com/prometheus && \
        git clone https://github.com/prometheus/prometheus.git --depth 1
RUN cd $GOPATH/src/github.com/prometheus/prometheus && git fetch --unshallow
RUN cd $GOPATH/src/github.com/prometheus/prometheus && make build
RUN chmod +x $GOPATH/src/github.com/prometheus/prometheus/prometheus
RUN chmod +x $GOPATH/src/github.com/prometheus/prometheus/promtool
ENV PATH="${PATH}:$GOPATH/src/github.com/prometheus/prometheus"
RUN echo $PATH
COPY config.yml /etc/prometheus/config.yml
COPY entrypoint.sh /usr/bin/entrypoint.sh

RUN mkdir -p /var/log/prometheus/

EXPOSE 9090

ENTRYPOINT [ "entrypoint.sh" ]

CMD ["prometheus", "--config.file=/etc/prometheus/config.yml", "--storage.tsdb.path=/var/lib/prometheus/data", "--web.route-prefix=prometheus"]
