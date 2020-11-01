
# Drone GCP

## Glossary
| Name          | Description                                  |
|---------------|----------------------------------------------|
| Server        | GCE instance for Drone Server                |
| Agent         | GCE instance for Drone Runner                |
| Runner        | Drone Docker Runner                          |

## Infrastructure overview
- Server and Agents are deployed in one VPC network and in the same subnetwork.
- Server and Agents are Linux machines, they are using `ubuntu-1804-lts` image.
- All instances have an external IP and opened ports: 22 (ssh), 80 (http), 443 (https).
- Agents belong to the one auto-scaling group so that they can scale horizontally at high load.
- HTTPS with the server is provided with the Let's Encrypt certification.
- CoudSQL MySQL database is used as Drone database.
- We are using standalone nolimit Drone images.

## Required data resources:

#### data.google_service_account.server

Role:
roles/iam.serviceAccountKeyAdmin
Title:
Service Account Key Admin
Description:
For pulling drone images we need to login to GCR.
We use JSON key file authentication method and we need this role for generating Service Account Key.

---

Role:
roles/compute.instanceAdmin
Title:
Compute Instance Admin (beta)
Description:
We need this role for managing time-based Drone Agents autoscaling.

---

Role:
roles/storage.objectViewer
Title:
Storage Object Viewer
Description:
We need this role to pull Drone standalone images.

#### data.google_service_account.agent

Role:
roles/compute.storageAdmin
Title:
Compute Storage Admin
Description:
We need this role for:
- push/pull images to/from GCR.
- read secrets from GCS Bucket with secrets.

### google compute network
VPC Network for Drone deployment.

### google dns managed zone
DNS Zone for Drone Server hostname.

### google sql database instance
CouldSQL Instance for Drone db.

## Provisioning requirements

### Scalarizr proxy images
```
gcr.io/development-156220/int-scalarizr/windows-proxy

gcr.io/development-156220/int-scalarizr/ubuntu12.04-amd64

gcr.io/development-156220/int-scalarizr/ubuntu12.04-i386

gcr.io/development-156220/int-scalarizr/centos6-x86_64

gcr.io/development-156220/int-scalarizr/centos6-i386

gcr.io/development-156220/int-scalarizr/ubuntu1604-docker

gcr.io/development-156220/int-scalarizr/ubuntu1604-publisher
```

### GCS Bucket with secrets
GCS Bucket folder with secrets which will be mounted to `/share/.private.d` on Agent.
> NOTE: all secrets are **required**.
> This is not a complete list, as it is not clear how some keys work, please feel free to extend the description.

Overview:
- `docker.json` 
	github creds for buildbot.
-  `gcloud-account.json`
	 key to a service account with  associated roles : `roles/storage.admin`
- `git.id_rsa`
	SSH Private Key to github organization repos.
...

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| agent\_machine\_type | The machine type of the Drone Agent node.<br>  Agent machine must be powerful (more than the default) <br>  because the pipelines run on this machine. | `string` | `"n1-standard-1"` | no |
| agent\_service\_account\_id | Drone Agents Service Account.<br>  The Service account id.<br>  This is the part of the service account's email field that comes before the @ symbol. | `string` | n/a | yes |
| autoscaling\_cooldown\_period | Autoscaling, cooldown period in seconds. | `number` | `200` | no |
| autoscaling\_cpu\_utilization | Autoscaling, cpu utilization policy." | `number` | `0.8` | no |
| autoscaling\_max\_replicas | Autoscaling, max replicas. | `number` | `5` | no |
| autoscaling\_min\_replicas | Autoscaling, min replics. | `number` | `1` | no |
| cloudsql\_database\_name | CloudSQL MySQL database name. | `string` | `"drone"` | no |
| cloudsql\_database\_user | CloudSQL MySQL database user. | `string` | `"drone"` | no |
| cloudsql\_instance\_name | The name of CloudSQL instance where to create Drone database and user. | `string` | n/a | yes |
| cloudsql\_private\_ip | CloudSQL private IP to connect. | `string` | n/a | yes |
| compute\_extra\_labels | We have cleanup cloud resource mechanism and if you want your resources <br>  not to be removed you need to define a label with key `owner` and your nickname as value,<br>  It is relevant  only to `dev` workspace. | `map` | `{}` | no |
| dns\_zone\_name | DNS zone managed by a production account. | `string` | `"scalr-labs-net"` | no |
| drone\_cli\_version | Drone CLI version. | `string` | n/a | yes |
| drone\_email\_host | SMTP server host. | `string` | n/a | yes |
| drone\_email\_password | SMTP password. | `string` | n/a | yes |
| drone\_email\_port | SMTP server port, defaults to 587. | `number` | `587` | no |
| drone\_email\_username | SMTP username. | `string` | n/a | yes |
| drone\_github\_client\_id | Value configures the GitHub OAuth client id. | `string` | n/a | yes |
| drone\_github\_client\_secret | Value configures the GitHub oauth client secret. | `string` | n/a | yes |
| drone\_primary\_admin | When you configure the Drone server you can create the initial administrative account<br>  by passing the below environment variable, which defines the account username (e.g. github handle). | `string` | n/a | yes |
| drone\_runner\_version | Drone Runner version. | `string` | `"1.2"` | no |
| drone\_server\_version | Drone Server version. | `string` | `"1.7.0"` | no |
| gcs\_bucket\_folder\_with\_secrets | The GCS Bucker folder where the secrets are  stored.<br>  Agent pull this secrets and use in pipelines. | `string` | n/a | yes |
| github\_organization | GitHub Organization name. | `string` | n/a | yes |
| hostname | Drone endpoint will be ath ttps://[hostname].scalr-labs.net.<br>  Be careful about frequent server deployment.<br>  You can get a limit of a registration SSL certificate for that hostname. | `string` | `"drone"` | no |
| project | GCP Project for installation. | `string` | n/a | yes |
| region | GCP region of installation.<br>  The region should be as close as possible to the development team. | `string` | `"us-west1"` | no |
| runner\_capacity | Limits the number of concurrent pipelines that a runner can execute. | `number` | `5` | no |
| server\_machine\_type | The machine type of the Drone Server node.<br>  Server machine not need to be powerful because it only manages a queue.<br>  All pipeliners are running on the Agents. | `string` | `"n1-standard-1"` | no |
| server\_service\_account\_id | Drone Server Service Account.<br>  The Service account id.<br>  This is the part of the service account's email field that comes before the @ symbol. | `string` | n/a | yes |
| subnetwork\_ip\_range | IP range for subnetwork.<br>  Due to a lot of different subnets in a default VPC network Drone specified unique ip\_range. | `string` | `"10.25.10.0/24"` | no |
| vpc\_network\_name | VPC network of the Drone installation.<br>  This Drone deployment use existing VPC network that is different<br>  in the prod and dev environments. | `string` | n/a | yes |
| working\_hours | Possibility to define working hours in the format: <start>-<end>. <br>  Example: 09-20, Means workday starts in 09 and finish in 20. | `string` | `"09-20"` | no |
| working\_hours\_min\_replicas | Autoscaling, min replics in working hours.<br>  This value must be less than the value of autoscaling\_max\_replicas. | `number` | `2` | no |
| zone | GCP zone of installation. | `string` | `"us-west1-a"` | no |

## Outputs

| Name | Description |
|------|-------------|
| drone\_primary\_admin\_token | Drone primary admin token for using in Drone CLI. |
| hostname | Drone Server hostname. |
| installation\_id | Drone installation ID. This is required to monitor installation resources. |
| server\_public\_ip | The public IP address of the Drone Server |
| sql\_database\_password | The password to Cloud SQL Drone database. |
| ssh\_private\_key | The private SSH key to all Drone instances. |
| ssh\_user | The private SSH key to all Drone instances. |


# Workspaces

## Dev

Use Terraform remote state of **shared_gke** in workspace: `shared-gke-dev`
to provide:
- CloudSQL Instance
- VPC Network

### Inputs
| Name                               | Required | Default                         |
|------------------------------------|----------|---------------------------------|
| compute\_extra\_labels             | *        |                                 |
| drone\_github\_client_id           | *        |                                 |
| drone\_github\_\client\_secret     | *        |                                 |
| drone\_primary\_admin              | *        |                                 |
| shared\_gke\_organization          |          | org-sfuari395m7sck1             |
| agent\_service\_account\_id        |          | drone-agent                     |
| gcs\_bucket\_folder\_with\_secrets |          | gs://drone_bucket/dev/private.d |
| region                             |          | europe-west1                    |
| zone                               |          | europe-west1-b                  |
| hostname                           |          | drone                           |
| cloudsql\_database_name            |          | drone                           |
| cloudsql\_database_user            |          | drone                           |
| drone\_cli\_version                |          | 1.2.1                           |
| drone\_email\_host                 | *        |                                 |
| drone\_email\_password             | *        |                                 |
| drone\_email\_username             | *        |                                 |
| drone\_email\_port                 |          | 587                             |
| github\_organization               |          | Scalr                           |

---

## Prod

Use Terraform remote state of **shared_gke** in workspace: `shared-gke-prod`
to provide:
- CloudSQL Instance
- VPC Network

### Inputs
| Name                               | Required | Default        |
|------------------------------------|----------|----------------|
| drone\_github\_client\_id          | *        |                |
| drone\_github\_client\_secret      | *        |                |
| drone\_primary\_admin              | *        |                |
| shared\_gke\_organization          | *        |                |
| gcs\_bucket\_folder\_with\_secrets | *        |                |
| agent\_service\_account\_id .      | *        |                |
| region                             |          | europe-west1   |
| zone                               |          | europe-west1-b |
| hostname                           |          | drone          |
| cloudsql\_database\_name           |          | drone          |
| cloudsql\_database\_user           |          | drone          |
| drone\_cli\_version                |          | 1.2.1          |
| drone\_email\_host                 | *        |                |
| drone\_email\_password             | *        |                |
| drone\_email\_username             | *        |                |
| drone\_email\_port                 |          | 587            |
| github\_organization               |          | Scalr          |

--- 

# Cheetsheet

### Drone CLI usage:
```
export DRONE_SERVER=https://$(terraform output hostname)
export DRONE_TOKEN=$(terraform output drone_primary_admin_token)
drone info
```

### SSH to Server:
```
terraform output ssh_private_key > id_rsa && chmod 400 id_rsa
ssh -i id_rsa drone@$(terraform output server_public_ip)
```
> NOTE: you can use the same ssh key to ssh to Agents. 


### Terraform CLI for UI Workspaces:

1. Create main.tf
```
terraform {
  required_version = "~> 0.12.0"

  backend "remote" {}
}
```
2. Create backend.hcl
```
workspaces { name = "<workspace>" }
hostname     = "my.scalr.com"
token        = "<token>"
organization = "<org-name>"
```
3. Init terraform init `-backend-config=<path to backend.hcl>`.