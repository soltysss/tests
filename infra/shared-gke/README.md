# Provision GKE cluster with 1 worker node and CloudSQL database with VPN peering with cluster

Required Google APIs:

- Cloud Resource Manager API
- Cloud SQL Admin API
- Cloud SQL
- Kubernetes Engine API
- Service Networking API

Required IAM Roles:

- Editor
- Service Networking Admin
- Storage Admin

## About structure

- *modules* contains a terraform plans for provision all resources
- *workspaces* contains a different settings for development and production usage of shared-gke module.

## Requirements

Shared-gke module provide several variables:

- *region* - where cluster will be created
- *zone* - zone for node
- *cluster_name* - name for k8s cluster
- *database_instance_name* - name for Cloud SQL instance
