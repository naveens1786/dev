#!/bin/bash

set -e

IMAGE_NAME="devops-build"
IMAGE_TAG="latest"
CONTAINER_NAME="devops-build"
HOST_PORT="3000"
CONTAINER_PORT="3000"

echo "======================================"
echo "Deploying Docker Image"
echo "======================================"

echo "Stopping existing container..."

docker stop ${CONTAINER_NAME} 2>/dev/null || true

echo "Removing existing container..."

docker rm ${CONTAINER_NAME} 2>/dev/null || true

echo "Starting new container..."

docker run -d \
    --name ${CONTAINER_NAME} \
    --restart unless-stopped \
    -p ${HOST_PORT}:${CONTAINER_PORT} \
    ${IMAGE_NAME}:${IMAGE_TAG}

echo ""
echo "Deployment completed successfully."

echo ""
echo "Container status:"
docker ps --filter "name=${CONTAINER_NAME}"

echo ""
echo "Application test:"
curl -f http://localhost:${HOST_PORT} > /dev/null

echo "Application is responding on port ${HOST_PORT}."
