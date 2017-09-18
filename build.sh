#!/bin/bash
set -xe

find ./data -name '*.yaml' -exec ruby -e  "require 'yaml'; YAML.parse_file(\"{}\");" \;

