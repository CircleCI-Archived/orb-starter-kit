#!/bin/bash
_CCIAddSecrets() {
    # Add CIRCLE_TOKEN env var to CircleCI
    echo
    echo "Adding CIRCLE_TOKEN env var to project on CircleCI"
    CCI_TOKEN_ENV_RESPONSE=$(curl -s -o /dev/null -w "%{http_code}" -X POST --header "Content-Type: application/json" -d "{\"name\":\"CIRCLE_TOKEN\", \"value\":\"$CCI_TOKEN\"}" "https://circleci.com/api/v1.1/project/github/${CCI_ORGANIZATION}/${CCI_REPO}/envvar?circle-token=${CCI_TOKEN}")
    if [ ! "$CCI_TOKEN_ENV_RESPONSE" == "201" ]
    then
    echo "Failed to add CIRCLE_TOKEN env var to CircleCI. Please try again later."
    exit 1
    else
        echo "...CIRCLE_TOKEN env var added to CircleCI"
    fi
    echo
}