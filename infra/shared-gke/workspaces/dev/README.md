# Development GKE cluster

## Requirements

| Name | Version |
|------|---------|
| google | ~> 3.39.0 |
| google-beta | ~> 3.39.0 |

## Providers

No provider.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| cluster\_name | n/a | `string` | `"shared-gke-dev"` | no |
| database\_instance\_name | n/a | `string` | `"shared-mysql-dev"` | no |
| database\_instance\_type | The CloudSQL instance type (Second Generation) | `string` | `"db-f1-micro"` | no |
| max\_node\_count | Maximum number of Cluster nodes in the NodePool. Must be >= 1 | `number` | `1` | no |
| min\_master\_version | The Kubernetes version of the masters. If set to 'latest' it will pull latest available version in the selected region. Details: https://cloud.google.com/kubernetes-engine/versioning-and-upgrades#specifying_cluster_version | `string` | `"1.16"` | no |
| network\_name | The name of the VPC | `string` | `""` | no |
| node\_instance\_type | Instance type for cluster nodes | `string` | `"n1-standard-1"` | no |
| region | n/a | `string` | `"europe-west1"` | no |
| zone | n/a | `string` | `"europe-west1-b"` | no |

## Outputs

| Name | Description |
|------|-------------|
| cloudsql\_private\_ip | n/a |
| cluster\_ca\_certificate | n/a |
| cluster\_client\_certificate | n/a |
| cluster\_client\_key | n/a |
| cluster\_endpoint | n/a |
| cluster\_name | n/a |
| database\_instance\_name | n/a |
| ingress\_public\_ip | Load Balancer IPv4 address |
| kubectl\_context | n/a |
| vpc\_network | n/a |

