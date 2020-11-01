#
# Scalr variables
#

variable "region" {
  default     = "us-central1"
  description = "The VPC subnet region"
}

variable "zone" {
  default     = "us-central1-a"
  description = "The zone of the Scalr installation"
}

variable "scalr_machine_type" {
  default     = "n1-standard-2"
  description = "The machine type of the Scalr node"
}

variable "owner" {
  description = "Email or name of the owner"
}

variable "packagecloud_token" {
  default = "57dc71c2b9c55c7aca3172d4fb2f109ed2398f14b9eda09e"
}

variable "scalr_package_name" {
  default = ""
}
variable "installer_revision" {
  default     = ""
  description = <<EOF
The branch or revision of the installer-ng repository to update scalr server cookbook from.
EOF
}

variable "fatmouse_revision" {
  default     = ""
  description = <<EOF
The branch or revision of the fatmouse repository to update fatmouse from.
EOF
}

variable "int_scalr_revision" {
  default     = ""
  description = <<EOF
The branch or revision of the scalr repository to update scalr from.
EOF
}

variable "github_token" {
  default     = ""
  description = <<EOF
GitHub personal access tokens. See: https://github.com/settings/tokens
EOF
}

#
# Proxy variables
#

variable "proxy_machine_type" {
  default     = "f1-micro"
  description = "The machine type of the proxy node"
}

variable "proxy_port" {
  default     = 3128
  description = "The proxy port"
}
