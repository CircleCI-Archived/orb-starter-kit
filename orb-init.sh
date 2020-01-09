#!/bin/bash
clear
# remove git folder in the event a user clones the repo
rm -rf .git
# Load in functions
for PARTIAL in ./_init/*.sh; do
    . "$PARTIAL"
done
_textIntro
sleep 1
_installCLI
printf "\e[1mTesting authentication to GitHub.com\e[0m\n"
_checkGithubAuth
printf "\e[1mBegin Orb Creation\e[0m\n"
echo
sleep 1
_checkOrgName
_checkRepoName
echo
printf "\e[1mConnecting to remote\e[0m\n"
_gitSetup
printf "\e[1mSwitching to Alpha branch\e[0m\n"
git checkout -b Alpha
echo
_orbSetup
echo
sleep 1
printf "\e[1mAdding project to CircleCI\e[0m\n"
sleep 2
_followProject
echo
sleep 1
_configOptions
_CCIAddSecrets
_editConfig
sleep 1
echo "Replacing config in .circleci/config.yml with new modified config"
rm -rf .circleci/config.yml
mv config_modified.yml .circleci/config.yml
echo
printf "\e[1mCreating README.md\e[0m\n"
_editReadMe
echo
sleep 2
echo
echo
echo "Producing development orb"
circleci config pack src > orb.yml
circleci orb publish orb.yml "${CCI_NAMESPACE}/${CCI_ORBNAME}@dev:alpha"
sleep 2
_cleanup
echo "Commiting changes to Alpha branch"
git add .
git commit -m "Setup complete"
git push -u origin Alpha
_textComplete
rm -f "$0"
exit 0