# launchpad-starter

## Quickstart

- install all env deps
- create inventory.yaml
- make sure inventory path is correct
- `task hosts:base`
- `task k0s:k0s_install`

## Tooling deps
- ansible
- helm
- helmfile
- taskfile
- kubeseal
- ssh
- octant


## Todo
- add help task
- add local env setup using os-specific taskfiles

## dev

```
ln -s ../launchpad-core launchpad-core
```