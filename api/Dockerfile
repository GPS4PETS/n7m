FROM python:3.11-slim-bookworm

ENV NOMINATIM_VERSION=5.1.0

# https://nominatim.org/release-docs/latest/admin/Install-on-Ubuntu-24/

RUN apt-get update && apt-get install -y --no-install-recommends \
    g++ \
    curl \
    libicu-dev \
    pkg-config \
    postgresql-client-15 \
 && pip install --no-cache-dir \
    falcon \
    nominatim_api \
    uvicorn \
    osmium \
 && apt-get purge -y --auto-remove \
    g++ \
    pkg-config \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

# For uvicorn settings, see: https://www.uvicorn.org/deployment/
ENV PGHOST=gis \
    PGUSER=postgres \
    PGPASSWORD=change-this-password \
    WEB_CONCURRENCY=1

EXPOSE 8000

CMD [ "python3", "-m", "uvicorn", "nominatim_api.server.falcon.server:run_wsgi", "--proxy-headers", \
    "--host", "0.0.0.0", "--port", "8000", "--factory" ]
