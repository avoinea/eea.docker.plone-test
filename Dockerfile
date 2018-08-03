FROM plone:4
LABEL maintainer="EEA: IDM2 A-Team <eea-edw-a-team-alerts@googlegroups.com>"

RUN runDeps="curl git gcc libc-dev imagemagick ghostscript libmagickcore-6.q16-2-extra graphviz libjpeg62-turbo-dev" \
 && apt-get update \
 && apt-get install -y --no-install-recommends $runDeps \
 && rm -rf /var/lib/apt/lists/* \
 && mv develop.cfg develop-plone.cfg \
 && mv versions.cfg plone-versions.cfg \
 && mv /docker-entrypoint.sh /plone-entrypoint.sh

COPY develop.cfg /plone/instance/
COPY docker-entrypoint.sh /
RUN curl -O https://raw.githubusercontent.com/eea/eea.docker.kgs/96974-plone-4.3.17/src/plone/versions.cfg \
 && buildout -c develop.cfg
