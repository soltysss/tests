# Terraform Proxy Module

## Providers

| Name | Version |
|------|---------|
| google | n/a |
| null | n/a |
| random | n/a |
| template | n/a |
| tls | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:-----:|
| extra\_tags | n/a | `list` | `[]` | no |
| hostname | n/a | `any` | n/a | yes |
| index | n/a | `number` | `1` | no |
| machine\_type | n/a | `any` | n/a | yes |
| node\_depends\_on | n/a | `list` | `[]` | no |
| scalr\_id | n/a | `any` | n/a | yes |
| subnetwork\_self\_link | n/a | `any` | n/a | yes |
| zone | n/a | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| http\_proxy | The proxy URL |
| private\_ip | The private IP address of the proxy server |
| proxy\_password | Password of the user of the proxy server |
| proxy\_port | The port of the proxy server |
| proxy\_user | The user of the proxy server |
| public\_ip | The public IP address of the proxy server |
| ssh\_port | The SSH port |
| ssh\_private\_key | The private SSH key to the node |
| ssh\_user | The SSH user |

