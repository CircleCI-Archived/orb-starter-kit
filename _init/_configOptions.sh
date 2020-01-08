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
    read -p "Enter [y/n]: " -n 1 -r
    if [[ "$REPLY" =~ ^[Yy] ]]
    then
        ORBCONFIGOPT_PRCOMMENT="true"
        read -p "Enter the bot username: " ORBCONFIGOPT_BOT_USER
        echo "User: $ORBCONFIGOPT_BOT_USER"
        echo
        printf "\e[1mYOU MUST: set the environment variable PR_COMMENTER_GITHUB_TOKEN equal to the token of your GitHub bot user in the project settings on CircleCI.\e[0m?\n"
    fi
    echo
    echo
    printf "Enable \e[1mfail-if-semver-not-indicated\e[0m?\n"
    printf "Whether to fail if the commit subject did not include [semver:patch|minor|release|skip]"
    echo
    printf "This option is recommended."
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
    printf "This option will require the fingerprints of a private key added to CircleCI which has a corrisponding public key on GitHub with the permission to push a tag. Refer to readme for full docs."
    echo
    read -p "Enter [y/n]: " -n 1 -r
    if [[ "$REPLY" =~ ^[Yy] ]]
    then
        ORBCONFIGOPT_TAGPUSH="true"
    fi
    echo
    echo
}