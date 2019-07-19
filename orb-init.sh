#!/bin/bash
echo "-------------------"
echo -e "\e[38;5;45m\e[1mCircleCI Orb init\e[0m"
echo "-------------------"
echo
echo -e "\e[0mThis tool will help you create your first Orb with an automated build-test-deploy CircleCI Workflow."
echo "Follow along with the readme: https://github.com/CircleCI-Public/orb-starter-kit"
sleep 2
echo
echo "\e[1mInstalling CircleCI CLI\e[0m"
echo "This step will require SUDO to update the CLI"
echo
sleep 1
curl -fLSs https://circle.ci/cli | sudo bash && circleci setup
sleep 1
echo
CCI_TOKEN=$(grep -Po "(?<=token: ).*" "$HOME"/.circleci/cli.yml)
_checkGithubAuth() {
    echo "Testing authentication to GitHub.com"
    if [ ! $(ssh -T git@github.com | grep -q "success") ]
    then
        echo -e "\e[1m\e[91mUnable to authenticate with GitHub\e[0m"
        echo "It doesn't appear you are authenticated with Github."
        echo "Ensure you have added your SSH keypair to enable pushing and pulling from this environment"
        echo "https://help.github.com/en/articles/adding-a-new-ssh-key-to-your-github-account"
        exit 1
    else
    echo -e "\e[92mAuthenticated\e[0m"
    echo
    fi
}
_checkGithubAuth
echo -e "\e[1mBegin Orb Creation\e[0m"
echo
sleep 1
echo -e "\e[1mEnter your GitHub Organization name\e[0m"
read -p "Enter GitHub Orginzation name: " -r CCI_ORGANIZATION
_checkRepoName() {
    echo
    echo -e "\e[1mThe repoistory name is currently set to \e[36m$(basename "$PWD")\e[39m is this correct?\e[0m"
    read -p "Enter [y/n]: " -n 1 -r
    if [[ $REPLY =~ ^[Yy]$ ]]
    then
        CCI_REPO=$(basename "$PWD")
    elif [ $REPLY =~ ^[Nn]$ ]
    then
        echo -e "\e[1mEnter the GitHub repository name\e[0m"
        read -p "Enter repository: " -r CCI_REPO
    else
        _checkRepoName
    fi
}
_checkRepoName
echo
echo "Initializing git"
git init
git remote add origin git@github.com:"$CCI_ORGANIZATION"/"$CCI_REPO".git
git add .
git commit -m "initial commit"
git push -u origin master
sleep 1
echo "Create a GitHub Personal access token"
echo "The access token will be used to add a public key to your account automatically"
echo
sleep 1
echo "Create your peronal access token here: https://github.com/settings/tokens"
sleep 3
read -p "Enter GitHub Personal Access Token: " -r CCI_GH_TOKEN
echo
echo
echo -e "\e[1mSelect your Orb namespace. Each organization/user may claim one unique namespace.\e[0m"
read -p "Enter Namespace: " -r CCI_NAMESPACE
sleep 1
circleci namespace create "$CCI_NAMESPACE" github "$CCI_ORGANIZATION"
sleep 1
echo
echo -e "\e[1mSelect your Orb Name. Your Orb will live at ${CCI_NAMESPACE}/{ORB NAME}\e[0m"
read -p "Enter Orb Name: " -r CCI_ORBNAME
echo
sleep 1
echo "Orb ${CCI_NAMESPACE}/${CCI_ORBNAME} selected"
echo "Creating Orb"
sleep 2
echo
circleci orb create "${CCI_NAMESPACE}/${CCI_ORBNAME}"
echo
sleep 1
echo
echo -e "\e[1mCreating deployment key.\e[0m"
sleep 2
echo "The private key will automatically be added to the CircleCI repository for this project, and the public key will be added to the GitHub org. This will allow the Workflow to publish tagged commits to trigger integration tests and production Orb deployments."
ssh-keygen -t rsa -b 4096 -m PEM -N "" -f "${CCI_ORBNAME}-key"
echo
echo "${CCI_ORBNAME}-key keypair has been created"
CCI_FINGERPRINT=$(ssh-keygen -E md5 -lf "${CCI_ORBNAME}-key" | grep -Po "(?<=MD5:).+?(?=\s)")
echo "Private key fingerprint: $CCI_FINGERPRINT"
echo
sleep 1
echo -e "\e[1mAdding project to CircleCI\e[0m"
sleep 2
# Follow project on CircleCI
_followProject() {
    CCI_FOLLOW_RESPONSE=$(curl -s -X POST https://circleci.com/api/v1.1/project/github/"${CCI_ORGANIZATION}"/"${CCI_REPO}"/follow?circle-token="${CCI_TOKEN}")
    if [ ! $CCI_FOLLOW_RESPONSE = *'"following" : true']
    then
        echo "Unable to follow the project"
        echo
        echo $CCI_FOLLOW_RESPONSE
    else
        echo -e "\e[32mProject added to CircleCI\e[0m"
    fi
}
_followProject
echo
sleep 1
echo "Adding private key to CircleCI"
_CCIAddKey() {
    CCI_KEY_RESPONSE=$(curl -s -X POST --header "Content-Type: application/json" -d '{"hostname":"github.com","private_key":"'"$(cat "$CCI_ORBNAME-key")"'"}' "https://circleci.com/api/v1.1/project/github/${CCI_ORGANIZATION}/${CCI_REPO}/ssh-key?circle-token=${CCI_TOKEN}")
}
_CCIAddKey
echo "Adding public key to GitHub"
curl --silent -u "$CCI_ORGANIZATION:$CCI_GH_TOKEN" https://api.github.com/user -X POST --header "Content-Type: application/json" -d '{"title":"orb-deploy","key":"'"$(cat "$CCI_ORBNAME-key.pub")"'","read_only":false}' "https://api.github.com/repos/${CCI_ORGANIZATION}/${CCI_REPO}/keys" > /dev/null
echo  "Keys added"
echo "Removing local keys"
rm ${CCI_ORBNAME}-key
rm ${CCI_ORBNAME}-key.pub
echo
echo "Modifying config template"
_editConfig() {
    # replace all instances of namespace name
    sed -i "s/<orb-namespace>/$CCI_NAMESPACE/g" config.yml
    # replace all instances of orb name
    sed -i "s/<orb-name>/$CCI_ORBNAME/g" config.yml
    # replace all instances of fingerprint value
    sed -i "s/<orb-fingerprint>/$CCI_FINGERPRINT/g" config.yml
    echo "Config has been modified"
}
_editConfig
sleep 1
echo "Replacing config in .circleci/config.yml"
rm -rf .circleci/config.yml
mv config.yml .circleci
echo
echo "Producing development orb"
circleci config pack src > orb.yml
circleci orb publish orb.yml "${CCI_NAMESPACE}/${CCI_ORBNAME}@dev:alpha"
rm -rf orb.yml
echo "Commiting changes"
git add .
git commit -m "\e[1m\e[32mSetup complete\e[0m"
git push
echo
echo
echo
echo -e "\e[1mCongratulations! The setup is complete.\e[0m"
echo -e "Your orb currently lives at: \e[96m${CCI_NAMESPACE}\e[39m/\e[96m${CCI_ORBNAME}\e[39m@\e[92mdev:alpha\e[39m"
echo "You may see the current progress here: https://circleci.com/gh/$CCI_ORGANIZATION/workflows/$CCI_REPO"
echo "Begin to edit the files in the src directory to build your own orb."
echo "More information can be found in the readme"
exit 0
