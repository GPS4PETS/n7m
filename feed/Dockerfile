FROM python:3.11-slim-bookworm

ENV NOMINATIM_VERSION=5.0.0

# https://nominatim.org/release-docs/latest/admin/Install-on-Ubuntu-24/

RUN apt-get update && apt-get install -y --no-install-recommends \
    g++ \
    vim \
    procps \
    libicu-dev \
    osm2pgsql \
    pkg-config \
    postgresql-client-15 \
    curl \
    git \ 
 && pip install --no-cache-dir \
    nominatim_db \
    osmium \
 && apt-get purge -y --auto-remove \
    g++ \
    pkg-config \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

# For settings, see: https://nominatim.org/release-docs/develop/customize/Settings/
ENV PGHOST=gis \
    PGUSER=postgres \
    PGPASSWORD=change-this-password \
    OSM_FILENAME=

WORKDIR /nominatim

# copy shell scripts
COPY --chmod=0755 *.sh ./

# get osm2pgsql-themepark
#git clone https://github.com/osm2pgsql-dev/osm2pgsql-themepark data
#COPY project-search-map/osm2pgsql-style.lua data/.
#COPY project-search-map/.env data/.env
#RUN export LUAPATH=~/data/lua/?.lua

ENTRYPOINT [ "./entrypoint.sh" ]

#CMD ["tail", "-f", "/dev/null"]
CMD ["replication"]
