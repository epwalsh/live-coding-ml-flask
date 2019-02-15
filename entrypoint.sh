#!/bin/bash

# Exit script if any commands fail.
set -e

# Copy flask app into place.
cp /opt/python/app/petesapp/webserver/app.py /opt/python/app/application.py

# Download and cache word vectors to avoid overwriting and corrupting when app starts.
python -c 'from petesapp import glove'

# Execute the arguments to this script as commands themselves.
exec "$@"
