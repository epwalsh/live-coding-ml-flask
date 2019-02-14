FROM python:3.6

RUN apt-get update \
    && apt-get install -y \
        curl \
        build-essential \
        supervisor \
        nginx \
    && pip --no-cache-dir install --upgrade pip setuptools wheel \
    && rm -rf /var/lib/apt/lists/*

# Remove default nginx configurations
RUN rm -f /etc/nginx/nginx.conf && \
    rm -f /etc/nginx/conf.d/*.conf && \
    rm -f /etc/nginx/sites-enabled/*

# Create run pid path
RUN mkdir -p /run/nginx/

# Direct nginx logs to docker output
RUN ln -sf /dev/stdout /var/log/nginx/access.log && \
    ln -sf /dev/stderr /var/log/nginx/error.log

# Create nginx user
RUN adduser --system --no-create-home --shell /bin/false --group --disabled-login nginx

WORKDIR /opt/python/app

# Install application dependencies.
COPY requirements.txt requirements.txt
RUN pip --no-cache-dir install -r requirements.txt

# Copy nginx, uwsgi, and supervisord configuration
COPY nginx.conf /etc/nginx/nginx.conf
COPY supervisord.conf /etc/supervisord.conf

# Copy entrypoint into place.
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

COPY petesapp petesapp/

EXPOSE 5000

ENTRYPOINT ["/entrypoint.sh"]

CMD ["/usr/bin/supervisord", "-c", "/etc/supervisord.conf"]
