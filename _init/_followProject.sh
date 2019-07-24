_followProject() {
    CCI_FOLLOW_RESPONSE=$(curl -s -o /dev/null -w "%{http_code}" -X POST https://circleci.com/api/v1.1/project/github/"${CCI_ORGANIZATION}"/"${CCI_REPO}"/follow?circle-token="${CCI_TOKEN}")
    if [ ! "$CCI_FOLLOW_RESPONSE" = "201" ]
    then
        echo 
        echo "Unable to follow the project"
        echo
        exit 1
    else
        echo -e "\e[32mProject added to CircleCI\e[0m"
    fi
}