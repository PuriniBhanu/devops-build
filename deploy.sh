#!/bin/bash
set -e
IMAGE_NAME="devops-build-app"
CONTAINER_NAME="devops-build-container"
PORT=80
echo "-->Stopping old container if exists..."
docker stop $CONTAINER_NAME 2>/dev/null || true
docker rm $CONTAINER_NAME 2>/dev/null || true

echo "-->Running new container..."
docker run -d \
  --name $CONTAINER_NAME \
  -p $PORT:80 \
  $IMAGE_NAME:latest
echo "-->Application Deployed Successfully!"
echo "-->Access it at: http://localhost"
