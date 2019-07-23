_followProject() {
    CCI_FOLLOW_RESPONSE=$(curl -s -X POST https://circleci.com/api/v1.1/project/github/"${CCI_ORGANIZATION}"/"${CCI_REPO}"/follow?circle-token="${CCI_TOKEN}")
    if [[ ! "$CCI_FOLLOW_RESPONSE" = *'"following" : true' ]]
    then
        echo "Unable to follow the project"
        echo
        echo "$CCI_FOLLOW_RESPONSE"
    else
        echo -e "\e[32mProject added to CircleCI\e[0m"
    fi
}