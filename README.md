# k3d-demo

## Requirements

- [`docker`](https://docs.docker.com/get-docker/)
  - Note: k3d v5.x.x requires at least Docker v20.10.5 (runc >= v1.0.0-rc93) to work properly (see [#807](https://github.com/k3d-io/k3d/issues/807))
- [`k3d >= v5.0.0`](https://k3d.io/stable/#installation)
- [`Helm 3`](https://helm.sh/docs/intro/install/)
- [`kustomize`](https://kubectl.docs.kubernetes.io/installation/kustomize/)

## Resources

- <https://k3d.io/>
- <https://github.com/rancher/k3d>
- <https://kustomize.io/>
- <https://github.com/kubernetes-sigs/kustomize>

## Prepare

- Preparation (attention: clears all docker containers/volumes/networks!): `make prep`

### Quick Start

- Demo: Quick Start: `make demo-quickstart`

### Create Multi-Server Cluster

- Demo: Multi-Server Setup: `make demo-multiserver`

### Create Cluster from config file

- Demo: Creating a cluster from a config file: `make demo-configfile`

### Full Lifecycle with Helm

- Demo: Full k3d lifecycle with Helm and Golang App: `make demo-helm`

### Full Lifecycle with Kustomize

- Demo: Full k3d lifecycle with Kustomize and Golang App: `make demo-kustomize`
