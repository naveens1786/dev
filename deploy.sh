#!/bin/bash

set -e

IMAGE_NAME="${IMAGE_NAME:-devops-build:latest}"

echo "Deploying image: ${IMAGE_NAME}"

export IMAGE_NAME

docker compose pull || true

docker compose up -d --force-recreate

echo "Deployment completed."

docker compose ps
