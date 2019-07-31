#!/bin/bash
_checkRepoName() {
    echo
    printf "\e[1mThe repoistory name is currently set to \e[36m$(basename "$PWD")\e[39m is this correct?\e[0m\n"
    read -p "Enter [y/n]: " -n 1 -r
    if [[ "$REPLY" =~ ^[Yy]$ ]]
    then
        echo
        CCI_REPO=$(basename "$PWD")
    elif [[ "$REPLY" =~ ^[Nn]$ ]]
    then
    read -p "Enter GitHub repoistory name: " -r CCI_ORGANIZATION
    else
        _checkRepoName
    fi
}