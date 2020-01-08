#!/bin/bash
_checkRepoName() {
    echo
    printf "\e[1mThe repository name is currently set to \e[36m$(basename "$PWD")\e[39m is this correct?\e[0m\n"
    read -p "Enter [y/n]: " -n 1 -r
    if [[ "$REPLY" =~ ^[Yy]$ ]]
    then
        echo
        CCI_REPO=$(basename "$PWD")
    elif [[ "$REPLY" =~ ^[Nn]$ ]]
    then
    echo
    read -p "Enter GitHub repository name: " -r CCI_REPO
    else
        _checkRepoName
    fi
}
