variable "zone" {}
variable "machine_type" {}
variable "subnetwork_self_link" {}
variable "hostname" {}
variable "owner" {}
variable "scalr_id" {}

variable "packagecloud_token" {}
variable "github_token" {}

variable "index" {
  default = 1
}
variable "extra_tags" {
  default = []
}
variable "node_depends_on" {
  default = []
}
variable "http_proxy" {
  default = ""
}

variable "scalr_package_name" {
  default = ""
}
variable "installer_revision" {
  default = ""
}
variable "fatmouse_revision" {
  default = ""
}
variable "int_scalr_revision" {
  default = ""
}

variable "product_mode" {
  default = "iacp"
}
