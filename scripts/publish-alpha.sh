#!/bin/bash

# run like this:
# bash publish-alpha.sh your-namespace/your-orb-name

circleci config pack src > orb.yml
circleci orb publish orb.yml "$1@dev:alpha"
rm -rf orb.yml
