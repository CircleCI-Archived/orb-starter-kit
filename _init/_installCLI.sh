#!/bin/bash
_installCLI() {
    curl -fLSs https://circle.ci/cli | sudo bash && circleci setup
    sleep 1
    echo
    CCI_TOKEN=$(grep -Po "(?<=token: ).*" "$HOME"/.circleci/cli.yml)
}