_checkRepoName() {
    echo
    echo -e "\e[1mThe repoistory name is currently set to \e[36m$(basename "$PWD")\e[39m is this correct?\e[0m"
    read -p "Enter [y/n]: " -n 1 -r
    if [[ "$REPLY" =~ ^[Yy]$ ]]
    then
        echo
        CCI_REPO=$(basename "$PWD")
    else
        _checkRepoName
    fi
}