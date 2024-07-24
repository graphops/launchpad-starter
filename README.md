# Launchpad Starter

[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)

## Introduction

Launchpad is a toolkit for running a Graph Protocol Indexer on Kubernetes. It aims to provide the fastest path to production multi-chain indexing, with sane security and performance defaults. It should work well whether you have a single node cluster or twenty. It is comprised of an opinionated set of tools on your local machine, layered over one another to provide a declarative workflow to manage your deployments stack.

There are four major components to be aware of:

1. Launchpad Starter ([`graphops/launchpad-starter`](https://github.com/graphops/launchpad-starter)): A starting point for every new Launchpad deployment
2. Launchpad Charts ([`graphops/launchpad-charts`](https://github.com/graphops/launchpad-charts)): A collection of Helm Charts for blockchains and web3 apps
3. Launchpad Namespaces ([`graphops/launchpad-namespaces`](https://github.com/graphops/launchpad-namespaces)): A collection of preconfigured Kubernetes Namespaces using Helmfile
4. Launchpad Taskfiles ([`graphops/launchpad-taskfiles`](https://github.com/graphops/launchpad-taskfiles)): A collection of preconfigured Tasks using Taskfile

## Features

- Actively maintained by [GraphOps](https://graphops.xyz) [and contributors](https://github.com/graphops/launchpad-charts/graphs/contributors)
- An opinionated starter ([`launchpad-starter`](https://github.com/graphops/launchpad-starter)) to define and manage your stack in a declarative, version controlled manner
- A collection of Helm Charts for deploying and monitoring blockchain nodes and Graph Protocol Indexers in Kubernetes, with P2P `NodePort` support
- Preconfigured namespaces for core cluster functions (logging, monitoring, etc) and major blockchains
- An automated dependency update pipeline for [`graphops/launchpad-charts`](https://github.com/graphops/launchpad-charts) and [`graphops/launchpad-namespaces`](https://github.com/graphops/launchpad-namespaces)

## Next Steps

Please see the [Quick Start](https://docs.graphops.xyz/launchpad/quick-start) guide in the [Documentation](https://docs.graphops.xyz/launchpad/intro).

## Updates

### Pulling in starter changes

From time to time, you may want to update your infra repo with the latest changes from our starter. 

Launchpad comes with a built in task to do this:

```shell
task launchpad:pull-upstream-starter
```

## Contributing

We welcome and appreciate your contributions! Please see the [Contributor Guide](/CONTRIBUTING.md), [Code Of Conduct](/CODE_OF_CONDUCT.md) and [Security Notes](/SECURITY.md) for this repository.

## See also

- [`graphops/launchpad-charts`](https://github.com/graphops/launchpad-charts)
- [`graphops/launchpad-namespaces`](https://github.com/graphops/launchpad-namespaces)
- [`graphops/launchpad-taskfiles`](https://github.com/graphops/launchpad-taskfiles)
