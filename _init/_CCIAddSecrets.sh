#!/bin/bash
_CCIAddSecrets() {
    echo -e "\e[1mCreating deployment key.\e[0m"
    sleep 2
    echo "The private key will automatically be added to the CircleCI repository for this project, and the public key will be added to the GitHub org. This will allow the Workflow to publish tagged commits to trigger integration tests and production Orb deployments."
    ssh-keygen -t rsa -b 4096 -m PEM -N "" -f "${CCI_ORBNAME}-key"
    echo
    echo "${CCI_ORBNAME}-key keypair has been created"
    CCI_FINGERPRINT=$(ssh-keygen -E md5 -lf "${CCI_ORBNAME}-key" | grep -Po "(?<=MD5:).+?(?=\s)")
    echo "Private key fingerprint: $CCI_FINGERPRINT"
    echo
    # Add Private key to CircleCI.
    echo "Adding private key to CircleCI"
    CCI_KEY_RESPONSE=$(curl -s -o /dev/null -w "%{http_code}" -X POST --header "Content-Type: application/json" -d '{"hostname":"github.com","private_key":"'"$(cat "$CCI_ORBNAME-key")"'"}' "https://circleci.com/api/v1.1/project/github/${CCI_ORGANIZATION}/${CCI_REPO}/ssh-key?circle-token=${CCI_TOKEN}")
    if [ ! "$CCI_KEY_RESPONSE" == "200" ]
    then
        echo "Failed to add private key to CircleCI. Please try again later."
        exit 1
    else
        echo "...private key added to CircleCI"
    fi
    CCI_TOKEN_ENV_RESPONSE=$(curl -s -o /dev/null -w "%{http_code}" -X POST --header "Content-Type: application/json" -d '{"CIRCLE_TOKEN":'\"$CCI_TOKEN\"'}' "https://circleci.com/api/v1.1/project/github/${CCI_ORGANIZATION}/${CCI_REPO}/envvar?circle-token=${CCI_TOKEN}")
    if [ ! "$CCI_TOKEN_ENV_RESPONSE" == "201" ]
    then
    echo "Failed to add CIRCLE_TOKEN env var to CircleCI. Please try again later."
    exit 1
    else
        echo "...CIRCLE_TOKEN env var added to CircleCI"
    fi
    GIT_KEY_RESPONSE=$(curl -s -o /dev/null -w "%{http_code}" -u "$CCI_ORGANIZATION:$CCI_GH_TOKEN" https://api.github.com/user -X POST --header "Content-Type: application/json" -d '{"title":"orb-deploy","key":"'"$(cat "$CCI_ORBNAME-key.pub")"'","read_only":false}' "https://api.github.com/repos/${CCI_ORGANIZATION}/${CCI_REPO}/keys")
    if [ ! "$GIT_KEY_RESPONSE" == "201" ]
    then
    echo "Failed to add public key to Github. Please try again later."
    exit 1
    else
        echo "...CIRCLE_TOKEN env var added to CircleCI"
    fi
    echo  "Keys added"
    echo "Removing local keys"
    rm ${CCI_ORBNAME}-key
    rm ${CCI_ORBNAME}-key.pub
    echo
}