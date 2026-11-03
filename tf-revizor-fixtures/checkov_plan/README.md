# checkov_plan

Configuration for the Checkov integration. It plans with no cloud credentials: the AWS provider
takes placeholder keys and skips every pre-flight API call, and no resource or data source reads
from AWS. The three resources are deliberately insecure, so a plan-based scan returns findings
instead of an empty result.

## Expected findings

Checkov 3.x against Terraform 1.16 / OpenTofu 1.13 with AWS provider 6.71.0:

| Scan mode | Failed | Passed |
| --- | --- | --- |
| Plan, `enable_public_ssh = true` (default) | 12 | 10 |
| Plan, `enable_public_ssh = false` | 9 | 6 |
| Code | 13 | 9 |

The failures on the default run are CKV_AWS_24 and CKV_AWS_382 and CKV2_AWS_5 on
`aws_security_group.open_ssh[0]`, CKV_AWS_3 and CKV_AWS_189 on `aws_ebs_volume.unencrypted`, and
CKV_AWS_18, CKV_AWS_21, CKV_AWS_144, CKV_AWS_145, CKV2_AWS_6, CKV2_AWS_61 and CKV2_AWS_62 on
`aws_s3_bucket.plain`.

`enable_public_ssh` sets `count` on the security group. With it set to `false` a plan-based scan
stops reporting the security group, while a code scan keeps reporting it: the resource is in the
configuration either way, and only the plan shows that it is not created.

## Reproduce locally

```shell
terraform init
terraform plan -out=tfplan
terraform show -json tfplan > plan.json
checkov --file=plan.json --compact
```
