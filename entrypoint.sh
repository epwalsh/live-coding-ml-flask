#!/bin/bash

# Exit script if any commands fail.
set -e
set -o pipefail

# Check that the environment variable has been set correctly
if [ -z "$SECRETS_BUCKET_PATH" ]; then
  echo >&2 'error: missing SECRETS_BUCKET_PATH environment variable'
  exit 1
fi

# Load the S3 secrets file contents into the environment variables
eval "$(aws s3 cp s3://"${SECRETS_BUCKET_PATH}" - | grep -Ev '^$|^#.*' | sed 's/^/export /')"

# Copy main Flask application file into place.
cp /opt/python/app/petesapp/webserver/app.py /opt/python/app/application.py

# Download and cache ML models here to avoid race conditions later.
python -c 'from petesapp import glove'

# Execute the arguments to this script as commands themselves.
exec "$@"
