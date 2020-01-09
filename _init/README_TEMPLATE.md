# <orb-name> Orb [![CircleCI Build Status](https://circleci.com/gh/<org-name>/<repo-name>.svg?style=shield "CircleCI Build Status")](https://circleci.com/gh/<org-name>/<repo-name>) [![CircleCI Orb Version](https://img.shields.io/badge/endpoint.svg?url=https://badges.circleci.io/orb/<orb-namespace>/<orb-name>)](https://circleci.com/orbs/registry/orb/<orb-namespace>/<orb-name>) [![GitHub License](https://img.shields.io/badge/license-MIT-lightgrey.svg)](https://raw.githubusercontent.com/<org-name>/<repo-name>/master/LICENSE) [![CircleCI Community](https://img.shields.io/badge/community-CircleCI%20Discuss-343434.svg)](https://discuss.circleci.com/c/ecosystem/orbs)

A description of your orb. Utilize this orb to easily add X to your CI/CD pipeline.

TODO:
When ready, you must _manually_ publish the first 1.0.0 version of your orb to initialize the production pipeline. After the first manual push you will no longer need to do this.

1. When 1.0.0 is ready, create a PR to `master` with the commit message `1.0.0 [semver:skip]`.
2. Merge to `master`
3. Manually publish 1.0.0 from the CLI using this command: ``


## Usage

Example use-cases are provided on the orb [registry page](https://circleci.com/orbs/registry/orb/<orb-namespace>/<orb-name>#usage-examples). Source for these examples can be found within the `src/examples` directory.


## Resources

[CircleCI Orb Registry Page](https://circleci.com/orbs/registry/orb/<orb-namespace>/<orb-name>) - The official registry page of this orb for all versions, executors, commands, and jobs described.  
[CircleCI Orb Docs](https://circleci.com/docs/2.0/orb-intro/#section=configuration) - Docs for using and creating CircleCI Orbs.  

### How To Contribute

We welcome [issues](https://github.com/<org-name>/<repo-name>/issues) to and [pull requests](https://github.com/<org-name>/<repo-name>/pulls) against this repository!

To publish a new production version:
* Create a PR to the `Alpha` branch with your changes. This will act as a "staging" branch.
* When ready to publish a new production version, create a PR from `Alpha` to `master`. The Git Subject should include `[semver:patch|minor|release|skip]` to indicate the type of release.
* On merge, the release will be published to the orb registry automatically.

For further questions/comments about this or other orbs, visit the Orb Category of [CircleCI Discuss](https://discuss.circleci.com/c/orbs).