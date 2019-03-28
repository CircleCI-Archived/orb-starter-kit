#!/bin/bash

# run like this:
# bash create-namespace.sh your-namespace your-vcs your-vcs-org
# e.g., bash create-namespace.sh test-namespace bitbucket test-org
# to create the namespace, you must have owner/admin privileges in the vcs org

circleci namespace create "$1" "$2" "$3"
