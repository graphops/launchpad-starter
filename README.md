# Launchpad Starter

[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)

**WARNING: Launchpad is ALPHA quality software. We are rapidly iterating to create the best UX for Indexers. Expect API-breaking changes for the next few weeks. Contributors are very welcome.**

## Introduction

Launchpad is a toolkit for running a Graph Protocol Indexer on Kubernetes. It aims to provide the fastest path to production multi-chain indexing, with sane security and performance defaults. It should work well whether you have a single host or twenty.

There are two components to be aware of:

1. Starter (this repo): A starting point for every new Launchpad deployment. It uses a submodule to import all templated definitions from Core.
2. Core ([`graphops/launchpad-core`](https://github.com/graphops/launchpad-core)): Templated tasks, release definitions, scripts and other components

- An opinionated starter (this repo) to define and manage your stack in a declarative, version controlled manner
- We make use of an opinionated set of local command line tools to manage and apply changes to your cluster
- A predefined set of tasks to deploy and manage Kubernetes onto any set of SSH-capable hosts you have
- A predefined set of release definitions for key components in the stack, including cluster services like monitoring and logging, as well as the Indexer stack

## Quickstart

### 1. Install Taskfile

Launchpad has a large number of tooling dependencies that will run on your local machine. The most important dependency is [Taskfile](https://taskfile.dev).

Follow the [installation instructions](https://taskfile.dev/installation/) for your environment and install Taskfile before continuing.

### 2. Use this starter for your new infra repo

Next, we are going to create the repository that will contain your new infrastructure's configuration. We're going to clone `launchpad-starter`, and then init it as a new git repo to version control your infrastructure configuration moving forward.

```shell
git clone --recursive --depth 1 https://github.com/graphops/launchpad-starter my-new-infra # clone the starter into my-new-infra
cd my-new-infra # move into my-new-infra
rm -rf .git # clear the existing git configuration 
git init # init a new git repo
git commit -m "feat: Initial clone from launchpad-starter" # commit the starter contents
```

The `--recursive` flag on `git clone` tells git to checkout all submodules while cloning. This is important because `launchpad-core` is imported as a submodule. If you forgot to do this, `task launchpad:update-core` should solve it for you.

All work on your infrastructure will take place in this new repo. We recommend carefully version controlling all changes you make to your infrastructure configuration.

### 3. Use a task to install all deps

The starter repo came with a default set of tasks defined in Taskfile.yaml, and imported from `launchpad-core`.

Running `task launchpad:deps` will install all required dependencies into your local environment.

```shell
task launchpad:deps
```

### 4. Update the configuration with your values

- .env
- update inventory.yaml
- update values.yaml overrides

### 5. Bootstrap your hosts with Kubernetes

First, let's apply the base host configuration to your hosts.

```shell
task hosts:apply-base
```

Next, we can install [K0s](https://k0sproject.io/), our chosen distribution of Kubernetes, onto your hosts.

```shell
task hosts:apply-k0s
```

### 6. Install releases into the cluster for base cluster services

Next we need to install key non-Graph components of our stack, including monitoring and logging systems.

```shell
task releases:apply-base
```

### 7. Install Erigon and Proxyd for Ethereum mainnet

```shell
task releases:apply -- eth-mainnet
```

### 8. Install the Indexer stack

```shell
task releases:apply -- indexer
```

## Contributing

We welcome and appreciate your contributions! Please see the [Contributor Guide](/CONTRIBUTING.md), [Code Of Conduct](/CODE_OF_CONDUCT.md) and [Security Notes](/SECURITY.md) for this repository.

## See also

- [`graphops/launchpad-core`](https://github.com/graphops/launchpad-core)
- [`graphops/helm-charts`](https://github.com/graphops/helm-charts)
