#!/bin/bash
_installCLI() {
    if [ -x "$(command -v circleci)" ]; then
        echo "circleci cli already installed"
        circleci setup
        echo "setting token internally"
        CLI_FILE_PATH=$(circleci diagnostic | grep "Config found:" | awk '{print $3}')        
    else
        echo "circleci cli not installed"
        curl -fLSs https://circle.ci/cli | sudo bash && circleci setup
        sleep 1
        echo
        echo "setting token internally"
        CLI_FILE_PATH="$HOME/.circleci/cli.yml"
    fi

    echo "$CLI_FILE_PATH"
    CCI_TOKEN=$(awk '/token:/ {print $2}' "$CLI_FILE_PATH")
}
