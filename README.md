# Orb Starter Kit
This orb starter kit will help you write your own orb.

Orbs are reusable [commands](https://circleci.com/docs/2.0/reusing-config/#authoring-reusable-commands), [executors](https://circleci.com/docs/2.0/reusing-config/#authoring-reusable-executors), and [jobs](https://circleci.com/docs/2.0/reusing-config/#jobs-defined-in-an-orb) (as well as [usage examples](https://github.com/CircleCI-Public/config-preview-sdk/blob/v2.1/docs/usage-examples.md))—snippets of CircleCI configuration—that can be shared across teams and projects. See [CircleCI Orbs](https://circleci.com/orbs), [Explore Orbs](https://circleci.com/orbs/registry), [Creating Orbs](https://circleci.com/docs/2.0/creating-orbs), and [Using Orbs](https://circleci.com/docs/2.0/using-orbs) for further information.

## Usage

### Getting started
1. Download (don't fork/clone!) this repository and unzip it
2. Create a new blank GitHub repository for your orb
3. Rename your downloaded, unzipped `orb-starter-kit-master` folder to match the name of your new GitHub repository
4. `cd` into the renamed folder and run `git init` to initalize it as a new local `git` repository
5. Push your new local `git` repository to the blank GitHub repository you created earlier:

```
git remote add origin git@github.com:$YOUR_GITHUB_USERNAME/$YOUR_GITHUB_REPOSITORY.git
git push -u origin master
```

6. Replace the `config.yml` in the `.circleci` directory with the one in the repository's root, or run the included `replace-config.sh` script
7. Add your new GitHub repository as a new project on CircleCI, so your new orb will be continuously built and tested as you write it

### Optional: setting up your local orb development environment
If you haven't already installed the [CircleCI CLI](https://github.com/circleci-public/circleci-cli), created an orb namespace, and/or registered your orb name with the orb registry, this repository includes scripts to help you do so, all located in the `orb-setup-scripts` directory.

1. Run the `install-cli.sh` script to install and configure the CircleCI CLI
2. Run the `create-namespace.sh` script like this:

```
bash create-namespace.sh your-desired-namespace your-github-org
```

3. Run the `create-orb.sh` script like this:

```
bash create-orb.sh your-namespace/your-desired-orb-name
```

_**Note:** to create a namespace or an orb, you must have owner/admin privileges in the GitHub org to which it is linked_

### Writing your orb
This orb provides a basic directory/file structure for a decomposed orb (where commands, jobs, examples, and executors each live in their own YAML file). Create each of your commands, jobs, examples, and executors within the requisite folders in the `src` directory.

On every new pushed commit, `src` will automatically be linted via `yamllint`, packed into a single `orb.yml` file, validated by the `circleci` CLI, and, if valid, published as a `dev` release to the orb registry.

Following are some resources to help you build and test your orb:

- [Tips for writing your first orb](https://circleci.com/blog/tips-for-writing-your-first-orb/)
- [How to make an easy and valuable open source contribution with CircleCI orbs](https://circleci.com/blog/how-to-make-an-easy-and-valuable-open-source-contribution-with-circleci-orbs/)
- Creating automated build, test, and deploy workflows for orbs: [part 1](https://circleci.com/blog/creating-automated-build-test-and-deploy-workflows-for-orbs/), [part 2](https://circleci.com/blog/creating-automated-build-test-and-deploy-workflows-for-orbs-part-2/)
