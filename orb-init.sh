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
echo "Begin Orb Creation"
echo
sleep 1
echo -e "\e[1mEnter your GitHub Organization name\e[0m"
read -p "Enter GitHub Orginzation name: " -r CCI_ORGINIZATION
echo
echo -e "\e[1mEnter the GitHub repository name\e[0m"
read -p "Enter repository: " -r CCI_REPO
echo
echo -e "\e[1mEnter CircleCI Personal Token: https://circleci.com/account/api\e[0m"
read -p "Enter CircleCI Token: " -r CCI_TOKEN
_setNamespace() {
    echo
    echo -e "\e[1mSelect your Orb namespace. Each organization/user may claim one unique namespace.\e[0m"
    read -p "Enter Namespace: " -r CCI_NAMESPACE
    echo -e "You have selected \e[1m${CCI_NAMESPACE}\e[0m Is this correct? [y/n]"
    read -n 1 -r
    if [[ ! $REPLY =~ ^[Yy]$ ]]
    then
        _setNamespace
    fi
}
_setNamespace
echo
echo -e "\e[1mSelect your Orb Name. Your Orb will live at ${CCI_NAMESPACE}/{ORB NAME}\e[0m"
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
