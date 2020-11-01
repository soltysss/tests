variable "zone" {}
variable "machine_type" {}
variable "subnetwork_self_link" {}
variable "hostname" {}
variable "scalr_id" {}
variable "owner" {}

variable "extra_tags" {
  default = []
}
variable "index" {
  default = 1
}
variable "node_depends_on" {
  default = []
}
