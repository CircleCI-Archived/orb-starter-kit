# Orb Starter Kit

This orb starter kit will help you write your own orb.

Orbs are reusable [commands](https://circleci.com/docs/2.0/reusing-config/#authoring-reusable-commands), [executors](https://circleci.com/docs/2.0/reusing-config/#authoring-reusable-executors), and [jobs](https://circleci.com/docs/2.0/reusing-config/#jobs-defined-in-an-orb), as well as [usage examples](https://github.com/CircleCI-Public/config-preview-sdk/blob/v2.1/docs/usage-examples.md)—snippets of CircleCI configuration—that can be shared across teams and projects. See [CircleCI Orbs](https://circleci.com/orbs), [Explore Orbs](https://circleci.com/orbs/registry), [Creating Orbs](https://circleci.com/docs/2.0/creating-orbs), and [Using Orbs](https://circleci.com/docs/2.0/using-orbs) for further information.

## Setup
1. Download (don't fork/clone!) this repository and unzip it
2. Create a new blank GitHub repository for your orb
3. Rename your downloaded, unzipped `orb-starter-kit-master` folder to match the name of your new GitHub repository
4. `cd` into the folder and run `git init` to initalize it as a new local `git` repository
5. Push your new local `git` repository to the blank GitHub repository you created earlier:

```
git remote add origin git@github.com:$YOUR_GITHUB_USERNAME/$YOUR_GITHUB_REPOSITORY.git
git push -u origin master
```
