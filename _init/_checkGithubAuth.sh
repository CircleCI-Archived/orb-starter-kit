#!/bin/bash
_checkGithubAuth() {
    echo "Testing authentication to GitHub.com"
    GITAUTHCHECK=$(ssh -T git@github.com 2>&1| grep successful)
    if [ -z "$GITAUTHCHECK" ]
    then
        printf "\e[1m\e[91mUnable to authenticate with GitHub\e[0m\n"
        echo "It doesn't appear you are authenticated with Github."
        echo "Ensure you have added your SSH keypair to enable pushing and pulling from this environment"
        echo "https://help.github.com/en/articles/adding-a-new-ssh-key-to-your-github-account"
        sleep 2
        exit 1
    else
    printf "\e[92mAuthenticated\e[0m\n"
    echo
    fi
}