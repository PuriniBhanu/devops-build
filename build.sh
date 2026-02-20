#!/bin/bash
set -e
IMAGE_NAME="devops-build-app"
TAG="1.0"
echo "Started Building Docker Image..."
docker build -t $IMAGE_NAME:$TAG .
echo "Docker Image( $IMAGE_NAME )Built Successfully!"
