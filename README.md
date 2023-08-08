# Launchpad Starter

[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)

**WARNING: Launchpad is ALPHA quality software. We are rapidly iterating to create the best UX for Indexers. Expect API-breaking changes for the next few weeks. Contributors are very welcome.**

## Introduction

Launchpad is a toolkit for running a Graph Protocol Indexer on Kubernetes. It aims to provide the fastest path to production multi-chain indexing, with sane security and performance defaults. It should work well whether you have a single node cluster or twenty.

There are two components to be aware of:

1. Starter (this repo): A starting point for every new Launchpad deployment.
2. Namespaces ([`graphops/launchpad-namespaces`](https://github.com/graphops/launchpad-namespaces)): Templated tasks, release definitions, scripts and other components

## Features

- Actively maintained by [GraphOps](https://graphops.xyz) [and contributors](https://github.com/graphops/launchpad-charts/graphs/contributors)
- Predefined release definitions for monitoring, logging and other cluster functions, as well as for the complete Graph Indexer Stack
- An opinionated starter (this repo) to define and manage your stack in a declarative, version controlled manner
- A workflow to seamlessly inherit new templated release updates, while still supporting a enormous degree of deployment flexibility

## Getting Started

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
