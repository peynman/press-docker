#!/bin/bash

## sql files do not support environment variables out of the box
## so use envsubst to replace environment vars in init sql files
## write them to new files (we have to becouse of how envsubst works)
## and then replace them with original sql files
for file in /docker-entrypoint-initdb.d/*; do envsubst < $file > $file.temp; rm $file; done
for file in /docker-entrypoint-initdb.d/*; do mv $file ${file%.*}; done
