## Requirements

| Name | Version |
|------|---------|
| helm | 1.3.0 |

## Providers

| Name | Version |
|------|---------|
| google | n/a |
| google-beta | n/a |
| helm | 1.3.0 |
| random | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| cluster\_name | The GKE cluster name | `any` | n/a | yes |
| database\_instance\_name | The CloudSQL instance name | `any` | n/a | yes |
| database\_instance\_type | The CloudSQL instance type (Second Generation) | `string` | `"db-f1-micro"` | no |
| max\_node\_count | Maximum number of nodes in the NodePool. Must be >= 1 | `number` | `1` | no |
| min\_master\_version | The Kubernetes version of the masters. If set to 'latest' it will pull latest available version in the selected region. Details: https://cloud.google.com/kubernetes-engine/versioning-and-upgrades#specifying_cluster_version | `any` | n/a | yes |
| network\_name | The name of the VPC | `string` | `""` | no |
| node\_instance\_type | Instance type for cluster nodes | `string` | `"n1-standard-1"` | no |
| region | n/a | `string` | `"us-west1"` | no |
| zone | n/a | `string` | `"us-west1-a"` | no |

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

