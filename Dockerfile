FROM plone:4
LABEL maintainer="EEA: IDM2 A-Team <eea-edw-a-team-alerts@googlegroups.com>"

RUN runDeps="curl git gcc libc-dev imagemagick ghostscript libmagickcore-6.q16-2-extra graphviz libjpeg62-turbo-dev libpng-dev" \
 && apt-get update \
 && apt-get install -y --no-install-recommends $runDeps \
 && rm -rf /var/lib/apt/lists/* \
 && mv develop.cfg develop-plone.cfg \
 && mv versions.cfg plone-versions.cfg \
 && mv /docker-entrypoint.sh /plone-entrypoint.sh

COPY develop.cfg /plone/instance/
RUN curl -O https://raw.githubusercontent.com/eea/eea.docker.kgs/master/src/plone/versions.cfg \
 && gosu plone buildout -c develop.cfg
COPY docker-entrypoint.sh /
