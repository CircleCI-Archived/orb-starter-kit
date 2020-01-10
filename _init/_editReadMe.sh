#!/bin/bash
_editReadMe() {
    # replace all instances of org name
    sed -i .bak "s/<org-name>/$CCI_ORGANIZATION/g" ./_init/README_TEMPLATE.md
    # replace all instances of repo name
    sed -i .bak "s/<repo-name>/$CCI_REPO/g" ./_init/README_TEMPLATE.md
    # replace all instances of namespace name
    sed -i .bak "s/<orb-namespace>/$CCI_NAMESPACE/g" ./_init/README_TEMPLATE.md
    # replace all instances of orb name
    sed -i .bak "s/<orb-name>/$CCI_ORBNAME/g" ./_init/README_TEMPLATE.md
    rm -f ./README.md
    cp ./_init/README_TEMPLATE.md ./README.md
}