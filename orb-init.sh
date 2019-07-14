#!/bin/bash
echo "CircleCI Orb init"
echo "This tool will help you create your first Orb with an automated build-test-deploy CircleCI Workflow."
echo "Follow along with the readme: https://github.com/CircleCI-Public/orb-starter-kit"
echo
echo "Begin Orb Creation"
echo
sleep 1
echo "Enter your GitHub Organization name"
read -p "Enter GitHub Orginzation name: " -r CCI_ORGINIZATION
echo
echo "Enter the GitHub repository name"
read -p "Enter repository: " -r CCI_REPO
echo
echo "Enter CircleCI Personal Token: https://circleci.com/account/api"
read -p "Enter CircleCI Token: " -r CCI_TOKEN
echo
_setNamespace() {
    echo "Select your Orb namespace. Each organization/user may claim one unique namespace."
    read -p "Enter Namespace: " -r CCI_NAMESPACE
}
_setNamespace
echo
read -p "You have chosen ${CCI_NAMESPACE}, keep? [y,n] " -n 1 -r
echo    # (optional) move to a new line
if [[ $REPLY =~ ^[Nn]$ ]]
then
    _setNamespace
fi
echo "Select your Orb Name. Your Orb will live at ${CCI_NAMESPACE}/{ORB NAME}"
read -p "Enter Orb Name: " -r CCI_ORBNAME
echo
echo "Orb ${CCI_NAMESPACE}/${CCI_ORBNAME} selected"
echo
echo "Creating deployment key."
sleep 2
echo "The private key will automatically be added to the CircleCI repository for this project, and the public key will be added to the GitHub org. This will allow the Workflow to publish tagged commits to trigger integration tests and production Orb deployments."
ssh-keygen -t rsa -b 4096 -m PEM -N "" -f ${CCI_ORBNAME}-key
echo
echo "${CCI_ORBNAME}-key keypair has been created"
echo
sleep 1
echo "Adding deployment key to CircleCI"
curl -X POST --header "Content-Type: application/json" -d '{"hostname":"github.com","private_key":"$(cat orb-key)"}' "https://circleci.com/api/v1.1/project/github/${CCI_ORGANIZATION}/${CCI_REPO}/ssh-key?circle-token=${CCI_TOKEN}"
