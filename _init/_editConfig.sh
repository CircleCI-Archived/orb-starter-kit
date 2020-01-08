#!/bin/bash
_setConfigSettings() {
    # Setting config options
    rm /tmp/cci_config_opts #delete temp file if it already exists.
    mktemp /tmp/cci_config_opts
    if [[ -n $ORBCONFIGOPT_PRCOMMENT ]]
    then
      echo "          add-pr-comment: true" >> /tmp/cci_config_opts
      echo "You have enabled the add-pr-comment option. This requires a bot user."
      echo
      read -p "Enter the bot GitHub User Token. This will be added to your project under the GH_BOT_USER_TOKEN environment variable.  :" -r GH_BOT_USER_TOKEN
      curl -X POST --header "Content-Type: application/json" -d '{"name":"GH_BOT_USER_TOKEN", "value":"'"$GH_BOT_USER_TOKEN"'"}' "https://circleci.com/api/v1.1/project/:vcs-type/"$CCI_ORGANIZATION"/"$CCI_REPO"/envvar?circle-token=:"$CCI_TOKEN""
      echo "          bot-token-variable: GH_BOT_USER_TOKEN" >> /tmp/cci_config_opts
      read -p "Enter the bot user's name." -r GH_BOT_USER_NAME
      echo "          bot-user: $GH_BOT_USER_NAME" >> /tmp/cci_config_opts
    else
      echo "          add-pr-comment: false" >> /tmp/cci_config_opts
    fi
    if [[ -n $ORBCONFIGOPT_SEMVERSUBJECT ]]
    then
      echo "          fail-if-semver-not-indicated: true" >> /tmp/cci_config_opts
    else
      echo "          fail-if-semver-not-indicated: false" >> /tmp/cci_config_opts
    fi
    if [[ -n $ORBCONFIGOPT_TAGPUSH ]]
    then
      echo "          publish-version-tag: true" >> /tmp/cci_config_opts
      echo "You must manually edit the SSH fingerprints in the config file at this time. Please do this as soon as possible to enable this feature."
      echo "          ssh-fingerprints: x" >> /tmp/cci_config_opts
      else
      echo "          publish-version-tag: false" >> /tmp/cci_config_opts
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
    sed '/<orb-config-opts>/ {
        x
        r /tmp/cci_config_opts
      }' config.yml | tee config_modified.yml
    echo "Config has been modified"
}