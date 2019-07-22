# Orb Starter Kit ![CircleCI status](https://circleci.com/gh/CircleCI-Public/orb-starter-kit.svg "CircleCI status") [![CircleCI Community](https://img.shields.io/badge/community-CircleCI%20Discuss-343434.svg)](https://discuss.circleci.com/c/ecosystem/orbs)
This orb starter kit will help you write your own orb.

Orbs are reusable [commands](https://circleci.com/docs/2.0/reusing-config/#authoring-reusable-commands), [executors](https://circleci.com/docs/2.0/reusing-config/#authoring-reusable-executors), and [jobs](https://circleci.com/docs/2.0/reusing-config/#jobs-defined-in-an-orb) (as well as [usage examples](https://github.com/CircleCI-Public/config-preview-sdk/blob/v2.1/docs/usage-examples.md))—snippets of CircleCI configuration—that can be shared across teams and projects. See [CircleCI Orbs](https://circleci.com/orbs), [Explore Orbs](https://circleci.com/orbs/registry), [Creating Orbs](https://circleci.com/docs/2.0/creating-orbs), and [Using Orbs](https://circleci.com/docs/2.0/using-orbs) for further information.

## What is in this kit?

In this Orb-Starter-Kit you will find an automated setup to create a development pipeline to build your orb automatically. Once setup is complete you will have a functioning hello-world orb that is automatically build and released on each commit. Commits to the "Master" branch will trigger production Orb releases and other branches will create development versions of your Orb for testing.

### Prerequisites

Before getting started you will need the the following things:
1. A CircleCI account.
2. Git installed and configured locally.
3. A CircleCI [Personal API Token](https://circleci.com/docs/2.0/managing-api-tokens/#creating-a-personal-api-token)
4. A GitHub [Personal Access Token](https://help.github.com/en/articles/creating-a-personal-access-token-for-the-command-line)


## Usage

### Getting started
1. Download (don't fork/clone!) this repository and unzip it
2. Rename the folder to the name you would like to give your orb
3. Run the `orb-init.sh` script to begin.

Once the orb is complete, you will have two new Green workflows in your CircleCI account. The first one for the initial setup and the second one will have produced a development version of your orb which contains a sample Command, Executor, and Job. 

You may now simply modify these examples and add your own. Any new commit to the repo automatically trigger a development pipeline

#### What happens when I push a commit?

The Orb CI/CD pipeline begins! Your Orb will go through the `lint-pack_validate_publish-dev` workflow. The code will first be linted, then passed to the "pack" job which will take your multiple partial yaml files and condense them into a single Orb.yml file, lastly, if specified within the `config.yml`, and defined integration tests will also be ran.

Based on the branch you push to, the workflow will automatically create a development version of your orb for any branch except for "Master" which will create a production release which will be automatically incremented.

### Writing your orb
This orb provides a basic directory/file structure for a decomposed orb (where commands, jobs, examples, and executors each live in their own YAML file). Create each of your commands, jobs, examples, and executors within the requisite folders in the `src` directory.

Following are some resources to help you build and test your orb:

- [Tips for writing your first orb](https://circleci.com/blog/tips-for-writing-your-first-orb/)
- [How to make an easy and valuable open source contribution with CircleCI orbs](https://circleci.com/blog/how-to-make-an-easy-and-valuable-open-source-contribution-with-circleci-orbs/)
- Creating automated build, test, and deploy workflows for orbs: [part 1](https://circleci.com/blog/creating-automated-build-test-and-deploy-workflows-for-orbs/), [part 2](https://circleci.com/blog/creating-automated-build-test-and-deploy-workflows-for-orbs-part-2/)
