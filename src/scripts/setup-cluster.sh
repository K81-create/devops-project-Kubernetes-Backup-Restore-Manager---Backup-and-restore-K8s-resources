#!/bin/bash
# Setup script for local testing (e.g., Minikube)
echo "Setting up local Minikube cluster for testing..."
minikube start --driver=docker
echo "Cluster is running!"
