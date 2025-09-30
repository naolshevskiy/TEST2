#! /bin/env bash
export DOCKER_HOST_IP="192.168.56.18"
# export DOCKER_HOST_EXTERNAL_IP="158.160.48.205"

# create kind cluster
envsubst < config.yml | kind create cluster --config=-

# # add external ip docker-machine into kubeconfig
# echo "Edit kube config file..."
# sed -i "s/$DOCKER_HOST_IP/$DOCKER_HOST_EXTERNAL_IP/g" ~/.kube/config

# # get kubernetes cluster info
# kubectl --insecure-skip-tls-verify cluster-info