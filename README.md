# Launchpad Starter

[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)

**WARNING: Launchpad is ALPHA quality software. We are rapidly iterating to create the best UX for Indexers. Expect API-breaking changes for the next few weeks. Contributors are very welcome.**

## Introduction

Launchpad is a toolkit for running a Graph Protocol Indexer on Kubernetes. It aims to provide the fastest path to production multi-chain indexing, with sane security and performance defaults. It should work well whether you have a single host or twenty.

There are two components to be aware of:

1. Starter (this repo): A starting point for every new Launchpad deployment. It uses a submodule to import all templated definitions from Core.
2. Core ([`graphops/launchpad-core`](https://github.com/graphops/launchpad-core)): Templated tasks, release definitions, scripts and other components

## Features

- Actively maintained by [GraphOps](https://graphops.xyz) [and contributors](https://github.com/graphops/helm-charts/graphs/contributors)
- Deploy Kubernetes (K0s) onto any existing set of SSH-capable hosts you have
- Predefined release definitions for monitoring, logging and other cluster functions, as well as for the complete Graph Indexer Stack
- An opinionated starter (this repo) to define and manage your stack in a declarative, version controlled manner
- A workflow to seamlessly inherit new templated release updates, while still supporting a enormous degree of deployment flexibility

## Quickstart

### 1. Install Taskfile

Launchpad has a large number of tooling dependencies that will run on your local machine. The most important dependency is [Taskfile](https://taskfile.dev).

Follow the [installation instructions](https://taskfile.dev/installation/) for your environment and install Taskfile before continuing.

### 2. Use this starter for your new infra repo

Next, we are going to create the repository that will contain your new infrastructure's configuration. We're going to clone `launchpad-starter`, and then init it as a new git repo to version control your infrastructure configuration moving forward.

```shell
# Clone the starter into my-new-infra and cd into it
git clone --depth 1 https://github.com/graphops/launchpad-starter my-new-infra
cd my-new-infra

# Clear the existing Git repo and initialize a new one
rm -rf .git
git init
git add .
git commit -m "feat: Initial clone from launchpad-starter"
```

All work on your infrastructure will take place in this new repo. We recommend carefully version controlling all changes you make to your infrastructure configuration.

### 3. Install the launchpad-core submodule and all local dependencies

Next, we need to install the `launchpad-core` submodule, which contains Taskfile definitions, Helm Release templates and other useful things we will use. We also need to install all of the local tooling dependencies (like Helm or Kubectl) that we will need.

We can easily do both of these things by running the launchpad:setup command.

```shell
task launchpad:setup
# This will run two other tasks:
# launchpad:update-core, which will install the launchpad-core submodule
# launchpad:deps, which will install all the local tooling dependencies
```

Installing the `launchpad-core` submodule will leave an uncommitted change in our new repo, so let's commit that now.

```shell
git add .
git commit -m "feat: added launchpad-core submodule"
```

### 4. Update the configuration with your values

Next we need to fill out `inventory/inventory.yaml`. This file contains our host definitions. You can find sample configurations in `inventory/samples`.

### 5. Bootstrap your hosts with Kubernetes

First, let's apply the base host configuration to your hosts.

```shell
task hosts:apply-base
```

Next, we can install [K0s](https://k0sproject.io/), our chosen distribution of Kubernetes, onto your hosts.

```shell
task hosts:apply-k0s
```

We should now have our cluster credentials at `inventory/artifacts/k0s-kubeconfig.yml`. Let's make these our default credentials.

```shell
# Backup our existing credentials if we have any
mv ~/.kube/config ~/.kube/config.backup.$(date +%s)
# Copy our new config into the default location
cp inventory/artifacts/k0s-kubeconfig.yml ~/.kube/config
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

## Updates

### Updating `launchpad-core`

As new versions of key components in the stack are released, we will update `launchpad-core`'s templated definitions. You can easily inherit these updates by pulling down the latest submodule.

Launchpad comes with a built in task to do this:

```shell
task launchpad:update-core
```

### Pulling in starter changes

From time to time, you may want to update your infra repo with the latest changes from our starter. 

Launchpad comes with a built in task to do this:

```shell
task launchpad:pull-upstream-starter
```

## Contributing

We welcome and appreciate your contributions! Please see the [Contributor Guide](/CONTRIBUTING.md), [Code Of Conduct](/CODE_OF_CONDUCT.md) and [Security Notes](/SECURITY.md) for this repository.

## See also

- [`graphops/launchpad-core`](https://github.com/graphops/launchpad-core)
- [`graphops/helm-charts`](https://github.com/graphops/helm-charts)
