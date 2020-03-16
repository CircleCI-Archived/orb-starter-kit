# Orb Starter Kit [![CircleCI Build Status](https://circleci.com/gh/CircleCI-Public/orb-starter-kit.svg?style=shield "CircleCI Build Status")](https://circleci.com/gh/CircleCI-Public/orb-starter-kit) [![CircleCI Community](https://img.shields.io/badge/community-CircleCI%20Discuss-343434.svg)](https://discuss.circleci.com/c/ecosystem/orbs)

The Orb Starter Kit is a bash utility that makes creating your first orb a breeze!

**What are orbs?**
Orbs are reusable [commands](https://circleci.com/docs/2.0/reusing-config/#authoring-reusable-commands), [executors](https://circleci.com/docs/2.0/reusing-config/#authoring-reusable-executors), and [jobs](https://circleci.com/docs/2.0/reusing-config/#jobs-defined-in-an-orb) (as well as [usage examples](https://github.com/CircleCI-Public/config-preview-sdk/blob/v2.1/docs/usage-examples.md))—snippets of CircleCI configuration—that can be shared across teams and projects. See [CircleCI Orbs](https://circleci.com/orbs), [Explore Orbs](https://circleci.com/orbs/registry), [Creating Orbs](https://circleci.com/docs/2.0/creating-orbs), and [Using Orbs](https://circleci.com/docs/2.0/using-orbs) for further information.

## What is in this kit?

This kit includes three main components:

 * **Orb init script.**
    * The Orb init script will auytomatically generate for you a new GitHub repository with all of the source code needed to get started developing your own orb, complete with automation pipeline
* **Hello World template.**
    * Within the [/src](https://github.com/CircleCI-Public/orb-starter-kit/tree/master/src) folder you can find find the destructured source of a simple "Hello World" orb. You can simply copy this code and begin hacking, or initialize it with our orb init script.
* **Automated CI/CD Pipeline.**
    * After you run the init script you will also be automatically given a development pipeline to test and update your orb on CircleCI.
  * Automated Semver release process
  * Automated Integration Testing
  * No need to use CLI commands.



### Prerequisites

Before getting started you will need the the following things:
1. A CircleCI [account](https://circleci.com/signup/).
2. Git installed and configured locally.
3. A CircleCI [Personal API Token](https://circleci.com/docs/2.0/managing-api-tokens/#creating-a-personal-api-token) (Must be Org admin to claim a namespace and publish production Orbs)



## Usage

### Getting started
**1.** Clone this repo into a new directory with the name of your orb: 

```
git clone git@github.com:CircleCI-Public/orb-starter-kit.git My-Orb-Name
```

**2.** Create a new repository on GitHub with the same name. https://github.com/new

**3.** Run the `orb-init.sh` script to begin.

[![asciicast](https://asciinema.org/a/oSc3M8uJri4zfo616wOVbh1lO.svg)](https://asciinema.org/a/oSc3M8uJri4zfo616wOVbh1lO)

The Orb Init script will automate the following tasks:

>  * Install and update the CircleCI CLI
>  * Request a CircleCI API token if none is currently set.
>  * Check to ensure git is installed and authenticated with GitHub.
>  * Connect your repository with the blank repo created in step 2.
>  * Create and switch to an "Alpha" branch
>  * Walk through creating a new orb via the CircleCI CLI
>  * Allow you to optionally enable advanced features.
>  * Create your customized config file
>  * Clean up - The script will remove itself from the repo for the next commit.
>  * Commit alpha branch with changes to GitHub.

Your orb will now be available at `<your namespace>/<your orb>@dev:Alpha`

The script will end by giving you a link to the running automated pipeline on your CircleCI account which will be building a "Hello World" orb.



**4.** Begin editing.
> You may now edit the contents of the `/src` folder and commit your changes to the `Alpha` branch or any non-master branch.

**5.** Build and test!
> All commits to non-master branches will automatically result in the creation of a development orb under that branch. The automated pipeline will then run your integration tests against that newly created dev orb.

**6.** Publish!
> Once ready to produce a new production version of your orb, you may merge your branch into the master branch to trigger the automated release process.
>
>**Recommended:** If you have enabled the `fail-if-semver-not-indicated` option, your commit message when merging to master _MUST_ include `[semver:patch|minor|major|skip]` to designate the release type.
>
> You will need to manually publish the production version of your Orb for the initial version before the automated pipeline can update your production version later on. This is not needed on subsequent pushes. 

Once the orb is complete, you will have two new Green workflows in your CircleCI account. The first one is for the initial setup and the second one will have produced a development version of your orb which contains a sample Command, Executor, and Job. 


### Writing your orb
This orb provides a basic directory/file structure for a decomposed orb (where commands, jobs, examples, and executors each live in their own YAML file). Create each of your commands, jobs, examples, and executors within the requisite folders in the `src` directory.

Following are some resources to help you build and test your orb:

- [Intro to authoring orbs](https://circleci.com/docs/2.0/orb-author-intro/#section=configuration)
- [Orb Best Practices](https://circleci.com/docs/2.0/orbs-best-practices/#orb-best-practices-guidelines)
- [How to make an easy and valuable open source contribution with CircleCI orbs](https://circleci.com/blog/how-to-make-an-easy-and-valuable-open-source-contribution-with-circleci-orbs/)


### Permissions

Explanation of all permissions required for the script.

* **sudo** - The CircleCI CLI Update command will request sudo permissions to update.

### Preview

<details>
<Summary>Preview "Hello-World" Orb produced by this repo by default.</Summary>

```yaml
commands:
  greet:
    description: |
      Replace this text with a description for this command. # What will this command do? # Descriptions should be short, simple, and clear.
    parameters:
      greeting:
        default: Hello
        description: Select a proper greeting
        type: string
    steps:
    - run:
        command: echo << parameters.greeting >> world
        name: Hello World
description: |
  Sample orb description # What will your orb allow users to do? # Descriptions should be short, simple, and clear.
examples:
  example:
    description: |
      Sample example description. # What will this example document? # Descriptions should be short, simple, and clear.
    usage:
      jobs:
        build:
          machine: true
          steps:
          - foo/hello:
              username: Anna
      orbs:
        foo: bar/foo@1.2.3
      version: 2.1
executors:
  default:
    description: |
      This is a sample executor using Docker and Node. # What is this executor? # Descriptions should be short, simple, and clear.
    docker:
    - image: circleci/node:<<parameters.tag>>
    parameters:
      tag:
        default: latest
        description: |
          Pick a specific circleci/node image variant: https://hub.docker.com/r/circleci/node/tags
        type: string
jobs:
  hello:
    description: |
      # What will this job do? # Descriptions should be short, simple, and clear.
    executor: default
    parameters:
      greeting:
        default: Hello
        description: Select a proper greeting
        type: string
    steps:
    - greet:
        greeting: << parameters.greeting >>
orbs:
  hello: circleci/hello-build@0.0.5
version: 2.1
```

</details>
