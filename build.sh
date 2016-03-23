#!/bin/bash

MAINTAINER="pat.downey@gmail.com"
URL="https://github.com/patdowney/demo-hiera"
PACKAGE_NAME="demo-hiera"

bundle install --path vendor/bundle --binstubs .bundle/bin

VERSION=${TRAVIS_BUILD_NUMBER:-0}

mkdir -p .output
rm -rf .output/*

bundle exec  fpm -t deb -s dir \
  --package ".output/${PACKAGE_NAME}_${VERSION}_all.deb" \
  --name "${PACKAGE_NAME}" \
  --version "${VERSION}" \
  --depends 'puppet-agent' \
  --architecture all \
  --maintainer ${MAINTAINER} \
  --url ${URL} \
  --deb-user root \
  --deb-group root \
  hiera.yaml=/etc/hiera/hiera.yaml \
  data=/etc/hiera/
