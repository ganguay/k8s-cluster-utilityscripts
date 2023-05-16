#!/bin/bash

# Function to delete deployments
delete_deployments() {
  namespace=$1
  deployments=$(kubectl get deployments -n $namespace --no-headers=true | awk '{print $1}')
  
  for deployment in $deployments; do
    kubectl delete deployment $deployment -n $namespace
  done
}

# Function to delete replica sets
delete_replicasets() {
  namespace=$1
  replicasets=$(kubectl get replicasets -n $namespace --no-headers=true | awk '{print $1}')
  
  for replicaset in $replicasets; do
    kubectl delete replicasets $replicaset -n $namespace
  done
}

# Read namespaces from user input
read -p "Enter the namespaces (separated by space): " namespaces

# Loop through each namespace and delete deployments and replica sets
for namespace in $namespaces; do
  echo "Deleting deployments and replica sets in namespace: $namespace"
  delete_deployments $namespace
  delete_replicasets $namespace
done
