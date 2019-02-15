#!/bin/bash

# Exit script if any commands fail.
set -e
set -o pipefail

# Copy main Flask application file into place.
cp /opt/python/app/petesapp/webserver/app.py /opt/python/app/application.py

# Download and cache ML models here to avoid race conditions later.
python -c 'from petesapp import glove'

# Execute the arguments to this script as commands themselves.
exec "$@"
