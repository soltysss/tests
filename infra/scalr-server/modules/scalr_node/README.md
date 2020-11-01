# Terraform Scalr Module

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
| fatmouse\_revision | n/a | `string` | `""` | no |
| github\_token | n/a | `any` | n/a | yes |
| hostname | n/a | `any` | n/a | yes |
| http\_proxy | n/a | `string` | `""` | no |
| index | n/a | `number` | `1` | no |
| installer\_revision | n/a | `string` | `""` | no |
| int\_scalr\_revision | n/a | `string` | `""` | no |
| machine\_type | n/a | `any` | n/a | yes |
| node\_depends\_on | n/a | `list` | `[]` | no |
| packagecloud\_token | n/a | `any` | n/a | yes |
| product\_mode | n/a | `string` | `"iacp"` | no |
| scalr\_id | n/a | `any` | n/a | yes |
| scalr\_package\_name | n/a | `string` | `""` | no |
| subnetwork\_self\_link | n/a | `any` | n/a | yes |
| zone | n/a | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| admin\_password | The Scalr admin password |
| private\_ip | The private IP address of the scalr node |
| public\_ip | The public IP address of the scalr node |
| ssh\_port | The SSH port |
| ssh\_private\_key | The private SSH key to the node |
| ssh\_user | The SSH user |
| ssl\_extra\_ca\_file | The Scalr node CA bundle |