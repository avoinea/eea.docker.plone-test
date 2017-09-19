#!/bin/bash
set -e

python /docker-initialize.py

if [ -z "$GIT_BRANCH" ]; then
  GIT_BRANCH="master"
fi

if [ ! -z "$DEVELOP" ]; then
  GIT=`echo https://github.com/$DEVELOP | sed 's/src/eea/g'`
  git clone -v $GIT --branch=$GIT_BRANCH $DEVELOP
  if [ -e "custom.cfg" ]; then
    echo -e "[versions]" >> custom.cfg
    for addon in $ADDONS; do
      addon="$(echo $addon | sed 's|\[.*\]||g')"
      echo -e "$addon = >0.9" >> custom.cfg
    done
  fi
fi

if [ -e "custom.cfg" ]; then
    bin/buildout -c custom.cfg
fi

if [[ "$1" == "-"* ]]; then
  exec bin/test "$@"
fi

exec "$@"
