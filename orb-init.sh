#!/bin/bash
echo -e "\e[38;5;45m\e[1mCircleCI Orb init"
echo -e "\e[0mThis tool will help you create your first Orb with an automated build-test-deploy CircleCI Workflow."
echo "Follow along with the readme: https://github.com/CircleCI-Public/orb-starter-kit"
sleep 1
echo
echo "Installing CircleCI CLI"
curl -fLSs https://circle.ci/cli | sudo bash && circleci setup
sleep 1
echo
CCI_TOKEN=$(grep -Po "(?<=token: ).*" $HOME/.circleci/cli.yml)
echo -e "\e[1mBegin Orb Creation\e[0m"
echo
sleep 1
echo -e "\e[1mEnter your GitHub Organization name\e[0m"
read -p "Enter GitHub Orginzation name: " -r CCI_ORGINIZATION
echo
_checkRepoName() {
    echo
    echo -e "\e[1mThe repoistory name is currently set to \e[36m$(basename "$PWD")\e[39m is this correct?\e[0m"
    read -p "Enter [y/n]: " -n 1 -r
    if [[ $REPLY =~ ^[Yy]$ ]]
    then
        CCI_REPO=$(basename "$PWD")
    elif [[ $REPLY =~ ^[Nn]$ ]]
    then
        echo -e "\e[1mEnter the GitHub repository name\e[0m"
        read -p "Enter repository: " -r CCI_REPO
    else
        _checkRepoName
    fi
}
_checkRepoName
sleep 1
exec < /dev/tty
echo
_setNamespace() {
    exec < /dev/tty
    echo
    echo -e "\e[1mSelect your Orb namespace. Each organization/user may claim one unique namespace.\e[0m"
    read -p "Enter Namespace: " -r CCI_NAMESPACE
    echo
    echo -e "You have selected \e[1m${CCI_NAMESPACE}\e[0m"
    read -p "Are you sure? " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]
    then
        _setNamespace
    fi
}
_setNamespace
sleep 1
circleci namespace create "$CCI_NAMESPACE" github "$CCI_ORGANIZATION"
sleep 1
echo
echo -e "\e[1mSelect your Orb Name. Your Orb will live at ${CCI_NAMESPACE}/{ORB NAME}\e[0m"
read -p "Enter Orb Name: " -r CCI_ORBNAME
echo
echo "Orb ${CCI_NAMESPACE}/${CCI_ORBNAME} selected"
echo
echo "Creating deployment key."
sleep 2
echo "The private key will automatically be added to the CircleCI repository for this project, and the public key will be added to the GitHub org. This will allow the Workflow to publish tagged commits to trigger integration tests and production Orb deployments."
ssh-keygen -t rsa -b 4096 -m PEM -N "" -f "${CCI_ORBNAME}-key"
echo
echo "${CCI_ORBNAME}-key keypair has been created"
echo
sleep 1
echo "Adding project to CircleCI"
sleep 0.5
echo "This will result in a failing job momentarily while we continue to configure your project."
echo "Please disreguard these failures."
echo
sleep 2
curl -X POST https://circleci.com/api/v1.1/project/github/${CCI_ORGINIZATION}/${CCI_REPO}/follow?circle-token=${CCI_TOKEN}
echo "Project added to CircleCI"
echo
sleep 1
echo "Adding deployment key to CircleCI"
CCI_FINGERPRINT=$(curl -X POST --header "Content-Type: application/json" -d '{"hostname":"github.com","private_key":"$(cat ${CCI_ORBNAME}-key"}' "https://circleci.com/api/v1.1/project/github/${CCI_ORGANIZATION}/${CCI_REPO}/ssh-key?circle-token=${CCI_TOKEN}" | jq '.fingerprint')
echo -e "Deployment key added. Fingerprint: \e[31m$CCI_FINGERPRINT\e[39m"
