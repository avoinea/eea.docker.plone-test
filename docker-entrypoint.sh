#!/bin/bash
set -e

python /docker-initialize.py

if [ -z "$GIT_URL" ]; then
  GIT_URL="https://github.com"
fi

if [ -z "$GIT_BRANCH" ]; then
  GIT_BRANCH="master"
fi

if [ -z "$GIT_USER" ]; then
  GIT_USER="eea"
fi

LOCATION=$(pwd)
if [ ! -z "$DEVELOP" ]; then
  for dev in $DEVELOP; do
    if [ ! -d $dev ]; then
      GIT=`echo $GIT_URL/$dev | sed "s|src|$GIT_USER|g"`
      echo "Cloning $GIT"
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

if [[ "$1" == "zptlint"* ]]; then
  echo "Running bin/zptlint src/"
  find src -regex ".*\.[c|z]*pt" -print0 | xargs -0 -r bin/zptlint
  exit
fi

if [ -e "custom.cfg" ]; then
  bin/buildout -c custom.cfg
fi

if [[ "$1" == "-"* ]]; then
  exec bin/test "$@"
fi

exec /plone-entrypoint.sh "$@"
