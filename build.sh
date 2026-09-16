#!/bin/bash

set -e

IMAGE_NAME="devops-build"
IMAGE_TAG="${1:-latest}"

echo "Building Docker image..."

docker build \
  -t "${IMAGE_NAME}:${IMAGE_TAG}" .

echo "Docker image built successfully:"
docker images "${IMAGE_NAME}"
