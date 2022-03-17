# Testing Plone Docker Image

Docker Image optimized for running tests over Plone Add-ons


## Supported tags and respective Dockerfile links

  - [Tags](https://hub.docker.com/r/eeacms/plone-test/tags/)


## Base docker image

 - [hub.docker.com](https://hub.docker.com/r/eeacms/plone-test/)


## Source code

  - [github.com](http://github.com/eea/eea.docker.plone-test)


## Simple Usage

    $ docker run -it --rm \
                 -e ADDONS="eea.facetednavigation" \
                 -e DEVELOP="src/eea.facetednavigation" \
             eeacms/plone-test -s eea.facetednavigation


## Advanced Usage

    $ docker run -it --rm \
                 -e ADDONS="eea.facetednavigation" \
                 -e DEVELOP="src/eea.facetednavigation" \
                 -e GIT_USER="collective" \
                 -e GIT_CHANGE_ID=50 \
                 -e GIT_BRANCH=PR-50 \
            eeacms/plone-test -s eea.facetednavigation

## Testing with coverage and xunit reports

Xunit xml report files are saved in the container, in the path `/plone/instance/parts/xmltestreport/testreports/`

Coverage report is saved in the `/plone/instance/src/$GIT_NAME/coverage.xml` file

### Docker command

    $ docker run -it --name=plonetest \
                 -e ADDONS="eea.facetednavigation" \
                 -e DEVELOP="src/eea.facetednavigation" \
                 -e GIT_NAME="eea.facetednavigation" \
            eeacms/plone-test coverage

> We are keeping the container `Stopped` and will delete it after we copy the reports

### Copy from docker container

    $ mkdir xunit-reports
    $ docker cp plonetest:/plone/instance/parts/xmltestreport/testreports/. xunit-reports/
    $ docker cp plonetest:/plone/instance/src/eea.facetednavigation/coverage.xml coverage.xml
    
### Clean-up

    $ docker rm -v plonetest
    
## Supported environment variables

* `GIT_BRANCH` Run tests over the provided git branch (e.g.: `GIT_BRANCH=develop`). Default: `master`
* `GIT_CHANGE_ID` Run tests over a github pull-request (e.g.: `GIT_CHANGE_ID=PR-5`. Default: `<not-set>`
* `GIT_REMOTE_URL` Override git remote (e.g.: `GIT_REMOTE_URL=https://bitbucket.org`). Default: `https://github.com`. Experimental
* `GIT_USER` Override git user (e.g.: `GIT_USER=collective`). Default: `eea`
* `GIT_NAME` Used in coverage testing, to set the tested addon
* All Plone [supported environment variables](https://github.com/plone/plone.docker#supported-environment-variables)


## Supported commands

* `zptlint` Run `bin/zptlint` checks over all Page Templates within `/plone/instance/src`
* `-<bin/test option>` Run `bin/test $@`
* All Plone [supported commands](https://github.com/plone/plone.docker#usage)


## Copyright and license

The Initial Owner of the Original Code is European Environment Agency (EEA).
All Rights Reserved.

The Original Code is free software;
you can redistribute it and/or modify it under the terms of the GNU
General Public License as published by the Free Software Foundation;
either version 2 of the License, or (at your option) any later
version.

## Funding

[European Environment Agency (EU)](http://eea.europa.eu)
