#!/bin/bash
_setConfigSettings() {
    # Setting config options
    CONFIG_OPTIONS_TEMP=$(mktemp /tmp/cci_config_opts)
    if [[ -z $ORBCONFIGOPT_PRCOMMENT ]]
    then
      echo "  add-pr-comment: true" >> $CONFIG_OPTIONS_TEMP
      echo "  bot-token-variable: x" >> $CONFIG_OPTIONS_TEMP
      echo "  bot-user: x" >> $CONFIG_OPTIONS_TEMP
    fi
    if [[ -z $ORBCONFIGOPT_SEMVERSUBJECT ]]
    then
      echo "  fail-if-semver-not-indicated: true" >> $CONFIG_OPTIONS_TEMP
      else
      echo "  fail-if-semver-not-indicated: false" >> $CONFIG_OPTIONS_TEMP
    fi
    if [[ -z $ORBCONFIGOPT_TAGPUSH ]]
    then
      echo "  publish-version-tag: true" >> $CONFIG_OPTIONS_TEMP
      echo "  ssh-fingerprints: x" >> $CONFIG_OPTIONS_TEMP
      else
      echo "  publish-version-tag: false" >> $CONFIG_OPTIONS_TEMP
    fi
    echo
}
_editConfig() {
    echo "Modifying config template"
    # replace all instances of namespace name
    sed -i .bak "s/<orb-namespace>/$CCI_NAMESPACE/g" config.yml
    # replace all instances of orb name
    sed -i .bak "s/<orb-name>/$CCI_ORBNAME/g" config.yml
    # replace all instances of fingerprint value
    sed -i .bak "s/<orb-fingerprint>/$CCI_FINGERPRINT/g" config.yml
    _setConfigSettings
    sed -i .bak "s/<orb-config-opts>/$(echo $CONFIG_OPTIONS_TEMP)/g" config.yml
    echo "Config has been modified"
}