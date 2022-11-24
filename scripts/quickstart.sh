#!/bin/bash

CURR_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )";
[ -d "${CURR_DIR}" ] || { echo "FATAL: no current dir (maybe running in zsh?)";  exit 1; }

source "${CURR_DIR}/common.sh";

section "Create a Cluster"
# info "Cluster Name: mycluster"
# info "--api-port 6550: expose the Kubernetes API on localhost:6550 (via loadbalancer)"
# info "--servers 1: create 1 server node"
# info "--agents 2: create 2 agent nodes"
# info "--port 8080:80@loadbalancer: map localhost:8080 to port 80 on the loadbalancer (used for ingress)"
# info "--volume $(pwd)/application:/src@all: mount the sub directory sample of the current directory to /src in all nodes (used for code)"
# info "--wait: wait for all server nodes to be up before returning"
info_pause_exec "Create a cluster" "k3d cluster create mycluster --api-port 6550 --servers 1 --agents 2 --port 8080:80@loadbalancer --volume $(pwd)/application:/src@all --wait"

section "Access the Cluster"

info_pause_exec "List clusters" "k3d cluster list"
# info "Cluster Name: mycluster"
# info "--kubeconfig-merge-default true: overwrite existing fields with the same name in kubeconfig (true by default)"
# info "--kubeconfig-switch-context true: set the kubeconfig's current-context to the new cluster context (false by default)"
info_pause_exec "Update the default kubeconfig with the new cluster details (Optional, included in 'k3d cluster create' by default)" "k3d kubeconfig merge mycluster --kubeconfig-merge-default --kubeconfig-switch-context"
info_pause_exec "Use kubectl to checkout the nodes" "kubectl get nodes"

section "Grow the Cluster"

info_pause_exec "Add 2 agents to the cluster" "k3d node create new-agent --cluster mycluster --role agent --replicas 2"
info_pause_exec "(Wait a bit for the nodes to get ready!) Use kubectl to see the new nodes" "kubectl get nodes"

section "Start/Stop the Cluster"

info_pause_exec "Stop the cluster" "k3d cluster stop mycluster"
info_pause_exec "Try to access the stopped cluster" "kubectl get nodes"
info_pause_exec "Start the cluster" "k3d cluster start mycluster"
info_pause_exec "Access restarted cluster" "kubectl get nodes"

section "The End"

info_pause_exec "Delete the Cluster" "k3d cluster delete mycluster"
