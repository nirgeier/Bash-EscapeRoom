#!/usr/bin/env bash
# Thin wrapper — delegates to the shared escaperoom-framework build script
SERVICE_NAME=escape-room-bash \
  IMAGE=${IMAGE:-ghcr.io/nirgeier/bash-escaperoom} \
  IMAGE_TAG=${IMAGE_TAG:-latest} \
  exec "$(git rev-parse --show-toplevel)/.escaperoom-framework/build.sh" "$@"
