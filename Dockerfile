FROM directus/directus:9.22

USER root

RUN \
  apk upgrade --no-cache && apk add --no-cache \
  libspatialite sqlite-dev

COPY --chown=node:node ./extensions/hooks/spatialite/index.js /directus/extensions/hooks/spatialite/index.js

USER node
WORKDIR /directus

# Expose data directories as volumes
VOLUME \
  /directus/database \
  /directus/extensions \
  /directus/uploads
