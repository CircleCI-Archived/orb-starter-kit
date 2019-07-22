_setCreateRepo() {
    GIT_REPO_CREATE_RES=$(curl -u "$CCI_ORGANIZATION":"$CCI_GH_TOKEN" -s -o /dev/null -w "%{http_code}" https://api.github.com/user/repos -X POST --header "Content-Type: application/json" -d '{"name":"'"$CCI_REPO"'","read_only":false}')
    if [ $GIT_REPO_CREATE_RES == "201"]
    then
        echo "GitHub Repo created."
        echo "https://github.com/$CCI_ORGANIZATION/$CCI_REPO"
        echo "You will find your orb here shortly."
        sleep 1
        echo
        echo "continuing..." 
        sleep 2
    elif [$GIT_REPO_CREATE_RES == "422"]
        echo "The repo $CCI_REPO already exists"
        echo "Please continue only if this is a new and empty repo created for this script."
        sleep 1
        read -p "Continue? [y/n]: " -n 1 -r
        if [[ ! $REPLY =~ ^[Yy]$ ]]
        then
            echo "Exiting"
            sleep 2
            exit 1
        fi
    fi
}