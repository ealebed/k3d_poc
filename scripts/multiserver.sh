#!/bin/bash

CURR_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
[ -d "${CURR_DIR}" ] || { echo "FATAL: no current dir (maybe running in zsh?)";  exit 1; }

source "${CURR_DIR}/common.sh"

section "Create a multi-server Cluster"

info_pause_exec "Create the cluster" "k3d cluster create demo --api-port 6550 --servers 3 --agents 3 --port 8080:80@loadbalancer --wait"
info_pause_exec "Update the default kubeconfig with the new cluster details" "k3d kubeconfig merge demo --kubeconfig-merge-default --kubeconfig-switch-context"

section "Access the Cluster"

info_pause_exec "List clusters" "k3d cluster list"
info_pause_exec "Using kubectl (with the default kubeconfig)" "kubectl get nodes"

section "The End"

info_pause_exec "Delete the Cluster" "k3d cluster delete demo"
