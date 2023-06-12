#!/bin/bash

# Set the image name and retrieve the current version
IMAGE_NAME="hello-world"
CURRENT_VERSION=$(docker images "$IMAGE_NAME" --format "{{.Tag}}" | sort -r | head -n 1)

# Increment the current version
NEXT_VERSION=$((CURRENT_VERSION + 1))

# Build the Docker image and tag it with the next version
docker build -t "$IMAGE_NAME:$NEXT_VERSION" .

# Push the tagged image to a Docker registry
docker push "$IMAGE_NAME:$NEXT_VERSION"

