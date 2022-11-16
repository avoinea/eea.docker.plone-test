FROM plone:python2
LABEL maintainer="EEA: IDM2 A-Team <eea-edw-a-team-alerts@googlegroups.com>"

RUN runDeps="curl git gcc libc-dev ghostscript libmagickcore-6.q16-2-extra graphviz libjpeg62-turbo-dev g++" \
 && apt-get update \
 && apt-get install -y --no-install-recommends $runDeps \
 && rm -rf /var/lib/apt/lists/* \
 && mv develop.cfg develop-plone.cfg \
 && mv /docker-entrypoint.sh /plone-entrypoint.sh

COPY develop.cfg /plone/instance/
RUN buildout -c develop.cfg \
 && chown -R plone:plone /plone
COPY docker-entrypoint.sh /
