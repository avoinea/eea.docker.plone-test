#!/bin/bash
set -e

python /docker-initialize.py

if [ ! -z "$BUILDOUT_DEVELOP" ]; then
  GIT=`echo https://github.com/$BUILDOUT_DEVELOP | sed 's/src/eea/g'`
  git clone -v $GIT $BUILDOUT_DEVELOP
  if [ -e "custom.cfg" ]; then
    echo -e "\n[versions]\n$BUILDOUT_EGGS = >0.9\n" >> custom.cfg
  fi
fi

if [ -e "custom.cfg" ]; then
    bin/buildout -c custom.cfg
fi

if [[ "$1" == "-"* ]]; then
  exec bin/test "$@"
fi

exec "$@"
