#!/bin/bash
_configOptions() {
    echo
    printf "\e[1mYou will now be given the option to enable advanced features for your pipeline.\e[0m?\n"
    echo
    printf "Enable \e[1madd-pr-comment\e[0m?\n"
    printf "This will allow you to specify a machine user to automatically comment on merged PRs with the final production version release of the orb."
    echo
    printf "This option will require the GitHub username and personal token of the machine user."
    echo
    echo
    read -p "Enter [y/n]: " -n 1 -r
    if [[ "$REPLY" =~ ^[Yy] ]]
    then
        ORBCONFIGOPT_PRCOMMENT="true"
        echo
        echo
        printf "\e[1mEnter the bot GitHub Username.\e[0m\n"
        read -p "Bot User: " GH_BOT_USER_NAME
        echo
        echo
        printf "\e[1mEnter the bot GitHub User Token.\e[0m\n"
        echo "This will be added to your project under the GH_BOT_USER_TOKEN environment variable."
        echo
        echo
        read -p "Bot Token: " -r GH_BOT_USER_TOKEN
        curl -X "POST" "https://circleci.com/api/v2/project/github/$CCI_ORGANIZATION/$CCI_REPO/envvar" \
            -H "Circle-Token: $CCI_TOKEN" \
            -H "Content-Type: application/json" \
            -H "Accept: application/json" \
            -d "{ \"name\": \"GH_BOT_USER_TOKEN\", \"value\": \"$GH_BOT_USER_TOKEN\"}"
    fi
    echo
    echo
    printf "Enable \e[1mfail-if-semver-not-indicated\e[0m?\n"
    printf "Whether to fail if the commit subject did not include [semver:patch|minor|release|skip]"
    echo
    printf "This option is recommended."
    echo
    echo
    read -p "Enter [y/n]: " -n 1 -r
    if [[ "$REPLY" =~ ^[Yy] ]]
    then
        ORBCONFIGOPT_SEMVERSUBJECT="true"
    fi
    echo
    echo
    printf "Enable \e[1mpublish-version-tag\e[0m?\n"
    printf "Push a git tag describing the release that was just published."
    echo
    printf "This option will require the fingerprints of a private key added to CircleCI which has a corresponding public key on GitHub with the permission to push a tag. Refer to readme for full docs."
    echo
    echo
    read -p "Enter [y/n]: " -n 1 -r
    if [[ "$REPLY" =~ ^[Yy] ]]
    then
        ORBCONFIGOPT_TAGPUSH="true"
    fi
    echo
    echo
}
