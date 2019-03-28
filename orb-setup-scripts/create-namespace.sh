#!/bin/bash

# run like this:
# bash create-namespace.sh your-namespace your-github-org
# e.g., bash create-namespace.sh test-namespace test-org
# to create the namespace, you must have owner/admin privileges in the github org

circleci namespace create "$1" github "$2"
