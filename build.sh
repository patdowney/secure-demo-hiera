#!/bin/bash

MAINTAINER="pat.downey@gmail.com"
URL="https://github.com/patdowney/secure-demo-hiera"
PACKAGE_NAME="secure-demo-hiera"

bundle install --path vendor/bundle --binstubs .bundle/bin


find ./data -name '*.yaml' -exec ruby -e  "require 'yaml'; YAML.parse_file(\"{}\");" \;

VERSION=${TRAVIS_BUILD_NUMBER:-0}

mkdir -p .output
rm -rf .output/*

bundle exec  fpm -t deb -s dir \
  --package ".output/${PACKAGE_NAME}_0.1.${VERSION}_all.deb" \
  --name "${PACKAGE_NAME}" \
  --version "${VERSION}" \
  --depends 'puppet' \
  --architecture all \
  --maintainer ${MAINTAINER} \
  --url ${URL} \
  --deb-user root \
  --deb-group root \
  hiera.yaml=/etc/hiera/hiera.yaml \
  data=/etc/hiera/
