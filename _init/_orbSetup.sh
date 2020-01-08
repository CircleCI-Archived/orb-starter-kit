#!/bin/bash
_orbSetup() {
    printf "\e[1mSelect your Orb namespace. \e[0m\n"
    printf "\e[1mEach organization/user may claim ONE UNIQUE namespace.\e[0m\n"
    echo
    echo "Ensure the name you choose is intended for the $CCI_ORGANIZATION organization, this CAN NOT be changed later."
    echo
    echo "You may see an error if you have already previously claimed this namespace in the past. This can safely be ignored for now."
    echo
    sleep 2
    read -p "Enter Namespace: " -r CCI_NAMESPACE
    echo
    if [ -z "$CCI_NAMESPACE" ]
    then
        echo
        echo "Namespace missing. Try again"
        _orbSetup
    fi
    echo
    echo
    sleep 1
    circleci namespace create "$CCI_NAMESPACE" github "$CCI_ORGANIZATION"
    sleep 1
    echo
    echo
    echo
    printf "\e[1mSelect your Orb Name. Your Orb will live at ${CCI_NAMESPACE}/\e[96m{ORB NAME}\e[0m\n"
    read -p "Enter Orb Name: " -r CCI_ORBNAME
    echo
    sleep 1
    echo "Orb ${CCI_NAMESPACE}/${CCI_ORBNAME} selected"
    echo "Creating Orb"
    sleep 2
    echo
    circleci orb create "${CCI_NAMESPACE}/${CCI_ORBNAME}"
    echo
    sleep 1
}