FROM plone/plone-backend:6.0
LABEL maintainer="EEA: IDM2 A-Team <eea-edw-a-team-alerts@googlegroups.com>"

COPY requirements.txt /app/

RUN runDeps="curl git build-essential libldap2-dev libsasl2-dev"  \
 && apt-get update \
 && apt-get install -y --no-install-recommends $runDeps \
 && rm -rf /var/lib/apt/lists/* \
 && mv /app/docker-entrypoint.sh /app/plone-entrypoint.sh \
 && chmod 777 /app/ \
 &&  pip wheel -r requirements.txt --wheel-dir=/wheelhouse ${PIP_PARAMS}

COPY docker-entrypoint.sh /app/
USER root
