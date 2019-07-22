#!/bin/bash
clear
# Load in functions
for PARTIAL in ./_init; do
    . $PARTIAL
done
_textIntro
sleep 1
_installCLI
_checkGithubAuth
_setGithubToken
echo -e "\e[1mBegin Orb Creation\e[0m"
echo
sleep 1
_checkOrgName
_checkRepoName
_setCreateRepo
echo
_gitSetup
echo
_orbSetup
echo
sleep 1
echo -e "\e[1mAdding project to CircleCI\e[0m"
sleep 2
_followProject
echo
sleep 1
_CCIAddSecrets
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
_textComplete
exit 0
