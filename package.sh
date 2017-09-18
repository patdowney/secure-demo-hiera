#!/bin/bash
set -xe

PACKAGE_MAINTAINER="pat.downey@gmail.com"
PACKAGE_URL="https://github.com/patdowney/secure-demo-hiera"

bundle install --path vendor/bundle --binstubs .bundle/bin

VERSION=${TRAVIS_BUILD_NUMBER:-0}

PACKAGE_NAME=${PACKAGE_NAME:-$(basename `pwd`)}

mkdir -p .output
rm -rf .output/*

PACKAGE_TYPE="deb"
bundle exec  fpm -t ${PACKAGE_TYPE} -s dir \
  --prefix / \
  --package ".output/${PACKAGE_NAME}_${PACKAGE_VERSION}-${VERSION}_all.${PACKAGE_TYPE}" \
  --name "${PACKAGE_NAME}" \
  --version "${PACKAGE_VERSION}-${VERSION}" \
  --architecture all \
  --maintainer "$PACKAGE_MAINTAINER" \
  --url $PACKAGE_URL \
  --deb-user root \
  --deb-group root \
  --verbose \
  hiera.yaml=/etc/hiera/hiera.yaml \
  data=/etc/hiera/

PACKAGE_TYPE="rpm"
bundle exec  fpm -t ${PACKAGE_TYPE} -s dir \
  --prefix / \
  --package ".output/${PACKAGE_NAME}_${PACKAGE_VERSION}-${VERSION}_all.${PACKAGE_TYPE}" \
  --name "${PACKAGE_NAME}" \
  --version "${PACKAGE_VERSION}-${VERSION}" \
  --architecture all \
  --maintainer "$PACKAGE_MAINTAINER" \
  --url $PACKAGE_URL \
  --rpm-user root \
  --rpm-group root \
  --verbose \
  hiera.yaml=/etc/hiera/hiera.yaml \
  data=/etc/hiera/
