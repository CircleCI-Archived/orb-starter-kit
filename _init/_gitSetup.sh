#!/bin/bash
_gitSetup() {
    echo "Checking for the existance of git@github.com:$CCI_ORGANIZATION/$CCI_REPO.git"
    echo
    sleep 1
    # check remote exists
    echo "Initializing local git repo"
    git ls-remote "git@github.com:$CCI_ORGANIZATION/$CCI_REPO.git" > /dev/null 2>&1
    if [ "$?" -ne 0 ]; then
        echo "[ERROR] It appears the remote repository may either not yet exist or you may not have access to it. Please create an empty repo on GitHub for this project prior to running the init script."
        exit 1;
    fi
    git init
    git remote add origin git@github.com:"$CCI_ORGANIZATION"/"$CCI_REPO".git
    git add .
    git commit -m "initial commit"
    echo
    sleep 1
    echo "Pushing initial configuration to setup project on CircleCI"
    sleep 1
    echo
    git push -u origin master || { echo "You do not appear to have access to this repository. Please ensure you have write permissions to this repo to push code."; exit 1; }
    sleep 1
}