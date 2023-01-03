FROM directus/directus:9.22

USER root

RUN \
  apk upgrade --no-cache && apk add --no-cache \
  libspatialite sqlite-dev

USER node
WORKDIR /directus

COPY ./patches /directus/patches
RUN npx patch-package

RUN \
  # Create data directories
  mkdir -p \
    extensions/hooks/spatialite

COPY --chown=node:node ./extensions/hooks/spatialite/index.js /directus/extensions/hooks/spatialite/index.js

# Prevents the previous COPY instruction to be discarded by the upstreem VOLUME instruction
# (Upstream has declared a /directus/extensions VOLUME)
# Ref: https://docs.docker.com/engine/reference/builder/#notes-about-specifying-volumes
VOLUME \
  /directus/extensions/hooks/spatialite
