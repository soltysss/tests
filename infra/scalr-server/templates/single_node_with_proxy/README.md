# The single node with proxy

## Providers

| Name | Version |
|------|---------|
| google | n/a |
| random | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:-----:|
| fatmouse\_revision | The branch or revision of the fatmouse repository to update fatmouse from. | `string` | `""` | no |
| github\_token | GitHub personal access tokens. See: https://github.com/settings/tokens | `string` | `""` | no |
| installer\_revision | The branch or revision of the installer-ng repository to update scalr server cookbook from. | `string` | `""` | no |
| int\_scalr\_revision | The branch or revision of the scalr repository to update scalr from. | `string` | `""` | no |
| packagecloud\_token | n/a | `string` | `"57dc71c2b9c55c7aca3172d4fb2f109ed2398f14b9eda09e"` | no |
| proxy\_machine\_type | The machine type of the proxy node | `string` | `"f1-micro"` | no |
| proxy\_port | The proxy port | `number` | `3128` | no |
| region | The VPC subnet region | `string` | `"us-central1"` | no |
| scalr\_machine\_type | The machine type of the Scalr node | `string` | `"n1-standard-2"` | no |
| scalr\_package\_name | n/a | `string` | `""` | no |
| zone | The zone of the Scalr installation | `string` | `"us-central1-a"` | no |

## Outputs

| Name | Description |
|------|-------------|
| admin\_password | The Scalr admin password |
| base\_64\_ssh\_private\_key | The private SSH key to the Scalr node (base64 encoded) |
| base\_64\_ssl\_extra\_ca\_file | The Scalr node CA bundle (base64 encoded) |
| http\_proxy | The HTTP proxy URL |
| oneliner\_add\_hosts\_record | Oneliner to add the Scalr node alias to the local machine |
| oneliner\_add\_ssh\_key | Oneliner to install the Scalr node SSH key |
| oneliner\_ssh\_to\_scalr | Oneliner to SSH to the Scalr node |
| private\_hostname | n/a |
| public\_ip | n/a |
| scalr\_id | n/a |
| ssh\_port | The SSH port of the Scalr node |
| ssh\_user | The SSH user of the Scalr node |
