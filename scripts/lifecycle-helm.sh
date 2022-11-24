#!/bin/bash

CURR_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )";
[ -d "${CURR_DIR}" ] || { echo "FATAL: no current dir (maybe running in zsh?)";  exit 1; }

source "${CURR_DIR}/common.sh";

section "Create a Cluster"

info_pause_exec "Create a cluster" "k3d cluster create demo --api-port 6550 --servers 1 --agents 3 --port 8080:80@loadbalancer --volume $(pwd)/application:/src@all --wait"

section "Access the Cluster"

info_pause_exec "List clusters" "k3d cluster list"
info_pause_exec "Use kubectl to checkout the nodes" "kubectl get nodes"

section "Use the Cluster"

info_pause_exec "Build the sample-http-server" "docker build application/ -f application/Dockerfile -t sample-http-server:local"
info_pause_exec "Load the sample-http-server image into the cluster" "k3d image import -c demo sample-http-server:local"
info_pause_exec "Create a new 'demo' namespace" "kubectl create namespace demo"
info_pause_exec "Deploy the sample-http-server with helm" "helm upgrade --install sample-http-server helm/charts/sample-http-server --namespace demo --set app.image=sample-http-server:local"

section "Access application frontend"
info_pause "Access the sample-http-server frontend via ingress: Please, visit http://sample.k3d.localhost:8080"

section "The End"

info_pause_exec "Delete the Cluster" "k3d cluster delete demo"
