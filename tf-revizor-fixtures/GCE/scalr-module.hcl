variable "tags" {
  policy = "cloud.tags"
  conditions = {
    cloud = "gce"
  }
}
