FROM plone/plone:4
MAINTAINER "EEA: IDM2 A-Team" <eea-edw-a-team-alerts@googlegroups.com>

USER root

RUN runDeps="gcc libc-dev" \
 && apt-get update \
 && apt-get install -y --no-install-recommends $runDeps \
 && rm -rf /var/lib/apt/lists/* \
 && mv develop.cfg develop-plone.cfg

COPY develop.cfg /plone/instance/

USER plone
