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
    echo -e "\n[versions]\n$ADDONS = >0.9\n" >> custom.cfg
  fi
fi

if [ -e "custom.cfg" ]; then
    bin/buildout -c custom.cfg
fi

if [[ "$1" == "-"* ]]; then
  exec bin/test "$@"
fi

exec "$@"
