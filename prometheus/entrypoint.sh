#!/bin/sh

# redirect stdout and stderr to files
exec 2>&1 | tee -a /var/log/prometheus/prometheus.log

# now run the requested CMD without forking a subprocess
exec "$@"