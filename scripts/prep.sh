#!/bin/bash

CURR_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
[ -d "${CURR_DIR}" ] || { echo "FATAL: no current dir (maybe running in zsh?)";  exit 1; }

source "${CURR_DIR}/common.sh"

section "Cleaning up docker environment (CAREFUL: STEPS ASK TO DELETE EVERYTHING IN DOCKER!)..."

if proceed_or_not "Section (Docker Cleanup: CAREFUL!)"; then
  info_pause_exec_options "REMOVE docker containers" "docker rm -f $(docker ps -qa | tr '\n' ' ')"
  info_pause_exec_options "REMOVE docker networks" "docker network prune -f"
  info_pause_exec_options "REMOVE docker volumes" "docker volume prune -f"
  info_pause_exec_options "PRUNE docker system" "docker system prune -a -f"
else
  echo "Skipped Section."
fi

section "Pulling images..."
docker pull rancher/k3s:v1.24.4-k3s1
docker pull ghcr.io/k3d-io/k3d-proxy:5.4.6
docker pull ghcr.io/k3d-io/k3d-proxy:5.4.6
docker pull golang:1.19
