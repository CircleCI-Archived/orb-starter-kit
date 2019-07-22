_checkOrgName() {
    echo -e "\e[1mEnter your GitHub Organization name\e[0m"
    read -p "Enter GitHub Orginzation name: " -r CCI_ORGANIZATION
    echo
    echo -e "\e[1mYou have selected \e[36m$CCI_ORGANIZATION\e[39m is this correct?\e[0m"
    read -p "Enter [y/n]: " -n 1 -r
    if [[ $REPLY =~ ^[Yy]$ ]]
    then
        echo "Organization set"
    else
        _checkOrgName
    fi
}