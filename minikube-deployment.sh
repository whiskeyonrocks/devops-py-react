#!/bin/bash

# Prerequisites 
# Docker
# minikube

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
CLUSTER_APP_NAME="webapp2"

# Docker login with username
docker login -u $DOCKER_USERNAME -p $DOCKER_TOKEN

# build and tag the image
# use --no-cache if needed.
# any change, nocache + version change - works
# any change, version change - works.
# any change, nocache - doesnt work
docker build -t $DOCKER_USERNAME/$IMAGE_NAME:$IMAGE_TAG $DOCKERFILE_PATH

# push to registry
docker image push $DOCKER_USERNAME/$IMAGE_NAME:$IMAGE_TAG

# minikube start
echo "Start minikube.."
minikube start

# Deploy to Minikube
echo "Deploying to Minikube..."
kubectl apply -f kubernetes/webapp-deployment.yml
# # kubectl apply -f kubernetes/webapp-service.yml

# # Optional: Open Minikube Service in Browser
minikube service $CLUSTER_APP_NAME

# If you have multiple Kubernetes clusters, switch between them using the kubectl config use-context command:
# kubectl config use-context your-cluster-name
