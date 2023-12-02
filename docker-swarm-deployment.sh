#!/bin/bash

# Prerequisites 
# Docker

# ** DEFINE A .env file or secrets with credentials to access the image repo.**

# Local Development
# Access the env file if available to get credentials.
if [ -f .env ]; then
  set -o allexport
  source .env set
  +o allexport
fi

# Set the desired image name and tag
IMAGE_NAME="docker-react"
IMAGE_TAG="5.0"
DOCKERFILE_PATH="./webapp"
SWARM_STACK_NAME="webapp"

# Docker login with username
docker login -u $DOCKER_USERNAME -p $DOCKER_TOKEN

# build and tag the image
# use --no-cache if needed.
docker build -t $DOCKER_USERNAME/$IMAGE_NAME:$IMAGE_TAG $DOCKERFILE_PATH

# push to registry
docker image push $DOCKER_USERNAME/$IMAGE_NAME:$IMAGE_TAG

# Remove the old Docker Swarm stack if it exists
docker stack rm webapp_stack 2>/dev/null

# Initialize Docker Swarm (if not already initialized)
docker swarm init 2>/dev/null || true

# Deploy the Docker Swarm stack
docker stack deploy -c docker-swarm/docker-stack.yml webapp_stack

# Open the web browser at the specified port
open "http://localhost:80"

# docker stack rm webapp_stack       