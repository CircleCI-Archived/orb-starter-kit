_orbSetup() {
    echo -e "\e[1mSelect your Orb namespace. Each organization/user may claim one unique namespace.\e[0m"
    echo "You may see an error if you have already previously claimed this namespace. This can safely be ignored for now."
    read -p "Enter Namespace: " -r CCI_NAMESPACE
    sleep 1
    circleci namespace create "$CCI_NAMESPACE" github "$CCI_ORGANIZATION"
    sleep 1
    echo
    echo -e "\e[1mSelect your Orb Name. Your Orb will live at ${CCI_NAMESPACE}/\e[96m{ORB NAME}\e[0m"
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