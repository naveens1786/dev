#!/bin/bash

set -e

IMAGE_NAME="devops-build"
IMAGE_TAG="latest"

echo "======================================"
echo "Building Docker Image"
echo "======================================"

docker build -t ${IMAGE_NAME}:${IMAGE_TAG} .

echo ""
echo "Docker image built successfully:"
docker images ${IMAGE_NAME}:${IMAGE_TAG}

echo ""
echo "Build completed successfully."
