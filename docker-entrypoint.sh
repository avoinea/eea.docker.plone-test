#!/bin/bash
set -e

python /docker-initialize.py

if [ -z "$GIT_BRANCH" ]; then
  GIT_BRANCH="master"
fi

LOCATION=$(pwd)
if [ ! -z "$DEVELOP" ]; then
  for dev in $DEVELOP; do
    if [ ! -d $dev ]; then
      GIT=`echo https://github.com/$dev | sed 's/src/eea/g'`
      git clone -v $GIT $dev
      cd $dev
      if [ ! -z "$GIT_CHANGE_ID" ]; then
        git fetch origin pull/$GIT_CHANGE_ID/head:$GIT_BRANCH
      fi
      git checkout $GIT_BRANCH
      cd $LOCATION
    fi
  done

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

exec /plone-entrypoint.sh "$@"
