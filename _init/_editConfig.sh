#!/bin/bash
_editConfig() {
    echo "Modifying config template"
    # replace all instances of namespace name
    sed -i "s/<orb-namespace>/$CCI_NAMESPACE/g" config.yml
    # replace all instances of orb name
    sed -i "s/<orb-name>/$CCI_ORBNAME/g" config.yml
    # replace all instances of fingerprint value
    sed -i "s/<orb-fingerprint>/$CCI_FINGERPRINT/g" config.yml
    echo "Config has been modified"
}