terraform {
  backend "remote" {
    hostname     = "my.scalr.com"
    organization = "org-skvcvdb6odtbbd0"
  }
}


provider "google" {
  region  = var.region
}

data "google_dns_managed_zone" "default" {
  name = var.dns_zone_name
}

resource "google_dns_record_set" "default" {
  name         = "${var.hostname}.${data.google_dns_managed_zone.default.dns_name}"
  type         = "CNAME"
  ttl          = 300
  managed_zone = data.google_dns_managed_zone.default.name
  rrdatas      = ["c.storage.googleapis.com."]
}

resource "google_storage_bucket" "default" {
  name          = "${substr(google_dns_record_set.default.name, 0, length(google_dns_record_set.default.name) - 1)}"
  storage_class = "NEARLINE"
  website {
    main_page_suffix = "index.html"
  }
}

resource "google_storage_bucket_acl" "default" {
  bucket = google_storage_bucket.default.name
  role_entity = [
    # Grant public access for OS package manager.
    "READER:allUsers",
    # Grant all access to fatmouse service account
    # format: user-<email>
    # see https://cloud.google.com/storage/docs/json_api/v1/objectAccessControls
    "OWNER:user-drone-903@scalr-labs.scalr.com.iam.gserviceaccount.com", # legacy drone (scalr-labs)
    "OWNER:user-fatmouse@development-156220.iam.gserviceaccount.com"
  ]
}

resource "google_storage_default_object_acl" "default" {
  bucket = google_storage_bucket.default.name
  role_entity = [
    # see google_storage_bucket.default
    "READER:allUsers",
    "OWNER:user-drone-903@scalr-labs.scalr.com.iam.gserviceaccount.com", # legacy drone (scalr-labs)
    "OWNER:user-fatmouse@development-156220.iam.gserviceaccount.com"
  ]
}

data "template_file" "index" {
  template = file("${path.module}/index.tpl.html")
  vars = {
    site_name = google_storage_bucket.default.name
  }
}

resource "google_storage_bucket_object" "index" {
  name    = "index.html"
  bucket  = google_storage_bucket.default.name
  content = data.template_file.index.rendered
  depends_on = [
    # or index.html will be uploaded "private"
    google_storage_default_object_acl.default
  ]
}

resource "google_storage_bucket_object" "apt-key-gpg" {
  name    = "scalarizr/apt-plain/develop/apt-key.gpg"
  bucket  = google_storage_bucket.default.name
  content = file("apt-key.gpg")
  depends_on = [
    # or will be uploaded as "private"
    google_storage_default_object_acl.default
  ]
}

resource "google_storage_bucket_object" "apt-key-legacy-gpg" {
  name    = "scalarizr/apt-plain/develop/apt-key-legacy.gpg"
  bucket  = google_storage_bucket.default.name
  content = file("apt-key-legacy.gpg")
  depends_on = [
    # or will be uploaded as "private"
    google_storage_default_object_acl.default
  ]
}
